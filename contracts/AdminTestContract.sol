// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

import "./InternalContracts/Contracts.sol";

contract AdminTestContract is InternalContracts {
    address public constant EVIL_ADDR = 0x1000000000000000000000000000000000000000;

    constructor() {
        // This should fail
        hijackAdmin();
        require(adminControl.getAdmin(address(this)) != EVIL_ADDR, "require admin != evil");
        // This should fail
        (bool success,) = address(this).call(abi.encodeWithSignature("clearAdmin()"));
        require(success, "setAdmin never revert");
        require(adminControl.getAdmin(address(this)) != address(0), "require admin != null");
        // This should succeed
        adminControl.setAdmin(address(this), address(0));
        require(adminControl.getAdmin(address(this)) == address(0), "require admin == null");
    }

    function deployAndHijackAdmin(bytes memory code) external payable returns (address) {
        address addr;
        bool success = true;
        uint value = msg.value;
        assembly {
            addr := create(value, add(code, 0x20), mload(code))
            if iszero(extcodesize(addr)) {
              success := 0
            }
        }
        require(success, "create failed");

        // Hijack the admin to an evil party.
        adminControl.setAdmin(addr, EVIL_ADDR);
        // Hijack the admin to null.
        adminControl.setAdmin(addr, address(0));
        return addr;
    }

    function clearAdmin() public {
        adminControl.setAdmin(address(this), address(0));
    }

    function hijackAdmin() public payable {
        // Hijack the admin to an evil party.
        adminControl.setAdmin(msg.sender, EVIL_ADDR);
    }
}
