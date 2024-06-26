// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import "./InternalContracts/Contracts.sol";


contract StaticCrossSpace is InternalContracts {
    constructor() {}

    function run() payable public {
        bytes20 addr = bytes20(uint160(4));
        bytes memory emptyBytes;
        bytes memory data = abi.encodeWithSelector(CrossSpaceCall.staticCallEVM.selector, addr, emptyBytes);
        (bool success, ) = address(crossSpaceCall).call(data);
        require(success, "Call Fail");
    }

    function run2() payable public {
        bytes20 addr = bytes20(uint160(4));
        bytes memory emptyBytes;
        bytes memory data = abi.encodeWithSelector(CrossSpaceCall.callEVM.selector, addr, emptyBytes);
        (bool success, ) = address(crossSpaceCall).staticcall(data);
        require(success, "Call Fail");
    }

    function run3Inner() payable public {
        bytes20 addr = bytes20(uint160(4));
        bytes memory emptyBytes;
        bytes memory data = abi.encodeWithSelector(CrossSpaceCall.callEVM.selector, addr, emptyBytes);
        (bool success, ) = address(crossSpaceCall).call(data);
        require(success, "Call Fail");
    }

    function run3() public {
        bytes memory data = abi.encodeWithSignature("run3Inner()");
        (bool success, ) = address(this).staticcall(data);
        require(success, "Call Fail");
    }
}