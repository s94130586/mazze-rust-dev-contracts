// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract CallTools {
    function recursiveCall(bytes memory data, uint256 restLevel, uint8[] memory returnFlags) public {
        bool success;
        if (restLevel >= 1) {
            (success, ) = address(this).call(abi.encodeWithSignature("recursiveCall(bytes,uint256,uint256)", data, restLevel - 1, returnFlags));
        } else {
            // When restLevel reaches 0, call the contract itself with the given data.
            (success, ) = address(this).call(data);
        }
        _processReturnFlag(success, returnFlags[restLevel]);
    }

    function multiCall(bytes[] memory callTasks) public {
        uint8[] memory returnFlags = new uint8[](callTasks.length);
        for (uint i=0; i< callTasks.length; i++) {
            returnFlags[i] = 0;
        }
        multiCallWithFlag(callTasks, returnFlags);
    }

    function multiCallWithFlag(bytes[] memory callTasks, uint8[] memory returnFlags) public {
        require(callTasks.length == returnFlags.length, "Inconsistent length of return flags");
        address[] memory receivers = new address[](callTasks.length);
        for (uint i=0; i< callTasks.length; i++) {
            receivers[i] = address(this);
        }
        multiCallExternalWithFlag(callTasks, receivers, returnFlags);
    }

    function multiCallExternal(bytes[] memory callTasks,  address[] memory receiver) public {
        require(callTasks.length == receiver.length, "Inconsistent length of return flags");
        uint8[] memory returnFlags = new uint8[](callTasks.length);
        for (uint i=0; i< callTasks.length; i++) {
            returnFlags[i] = 0;
        }
        multiCallExternalWithFlag(callTasks, receiver, returnFlags);
    }

    function callAnother(address receiver, bytes memory data, uint8 returnFlag) public {
        bytes[] memory callTasksArray = new bytes[](1);
        callTasksArray[0] = data;

        address[] memory receiverArray = new address[](1);
        receiverArray[0] = receiver;

        uint8[] memory returnFlagArray = new uint8[](1);
        returnFlagArray[0] = returnFlag;

        multiCallExternalWithFlag(callTasksArray, receiverArray, returnFlagArray);        
    }

    function multiCallExternalWithFlag(bytes[] memory callTasks, address[] memory receiver, uint8[] memory returnFlags) public {
        require(callTasks.length == returnFlags.length, "Inconsistent length of return flags");
        require(callTasks.length == receiver.length, "Inconsistent length of receiver");

        for (uint i = 0; i < callTasks.length; i++) {
            (bool success, ) = receiver[i].call(callTasks[i]);
            _processReturnFlag(success, returnFlags[i]);
        }
    }

    function selfRevert() pure public {
        revert();
    }

    function fail() pure public {
        assembly {
            invalid()
        }
    }

    function selfDestruct(address payable addr) public {
        selfdestruct(addr);
    }

    function _processReturnFlag(bool success, uint8 returnFlag) pure internal {
        /** Return Flag: 
         - 0: revert on error
         - 1: ignore error
         - 2: assert error
         - 3: early stop on error
         - 4: always error
        */
        if (!success) {
            if (returnFlag == 3) {
                return;
            } else if (returnFlag == 0) {
                revert("Revert because of execution fail");
            }
        } else {
            if (returnFlag == 2){
                revert("Revert because of unexpected success");
            }
        }
        if (returnFlag == 4){
            revert("Revert because of return flag");
        }
    }
}