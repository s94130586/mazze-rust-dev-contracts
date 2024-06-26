// SPDX-License-Identifier: MIT
pragma solidity >=0.4.15;

interface MazzeContext {
    /*** Query Functions ***/
    /**
     * @dev get the current epoch number
     * @return the current epoch number
     */
    function epochNumber() external view returns (uint256);

    /**
     * @dev get the height of the referred PoS block in the last epoch
`    * @return the current PoS block height
     */
    function posHeight() external view returns (uint256);

    /**
     * @dev get the epoch number of the finalized main block.
     * @return the finalized epoch number
     */
    function finalizedEpochNumber() external view returns (uint256);

    function epochHash(uint256) external view returns (bytes32);

}
