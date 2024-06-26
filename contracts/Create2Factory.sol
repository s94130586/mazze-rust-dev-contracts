// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Create2Factory {
  function callCreate2(
    uint256 salt,
    bytes calldata initializationCode
  ) external payable returns (address deploymentAddress) {
    // move the initialization code from calldata to memory. (use calldataload?)
    bytes memory initCode = initializationCode;
    uint256 msgValue = msg.value;

    // using inline assembly: load data and length of data, then call CREATE2.
    assembly { // solhint-disable-line
      let encoded_data := add(0x20, initCode) // load initialization code.
      let encoded_size := mload(initCode)     // load the init code's length.
      
      deploymentAddress := create2(           // call CREATE2 with 4 arguments.
        msgValue,                           // forward any attached value.
        encoded_data,                         // pass in initialization code.
        encoded_size,                         // pass in init code's length.
        salt                                  // pass in the salt value.
      )
    }

    // ensure that the contract address is not equal to the null address.
    require(
      deploymentAddress != address(0),
      "Failed to deploy contract using provided salt and initialization code."
    );
  }
}