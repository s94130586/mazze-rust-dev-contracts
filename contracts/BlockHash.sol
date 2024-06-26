// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract BlockHash {
    function getBlockHash(uint256 number) public view returns (bytes32) {
        return blockhash(number);
    }
}