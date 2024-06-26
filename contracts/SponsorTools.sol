// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./InternalContracts/Contracts.sol";

contract SponsorTools is InternalContracts {
    function setSponsored(address addr) public {
        address[] memory addrs = new address[](1);
        addrs[0] = addr;
        sponsorWhitelistControl.addPrivilege(addrs);
    }

    function resetSponsored(address addr) public {
        address[] memory addrs = new address[](1);
        addrs[0] = addr;
        sponsorWhitelistControl.removePrivilege(addrs);
    }
    
    function getSponsored(address addr) public view returns (bool) {
        return sponsorWhitelistControl.isWhitelisted(address(this), addr);
    }
}