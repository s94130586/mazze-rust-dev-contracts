// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Storage {

    constructor() {}

    function change(uint64 index) public {
        uint256 slot = uint256(index);
        assembly {
            sstore(slot, add(sload(slot), 1))
        }
    }

    function set(uint64 index) public {
        uint256 slot = uint256(index);
        assembly {
            sstore(slot, 1)
        }
    }

    function reset(uint64 index) public {
        uint256 slot = uint256(index);
        assembly {
            sstore(slot, 0)
        }
    }

    function assertValue(uint64 index, uint256 value) view public {
        uint256 slot = uint256(index);
        uint256 result;
        assembly {
            result := sload(slot)
        }
        require(result == value, "Unexpected value");
    }
}