// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

interface IHumansToken {
    /**
     * @dev To redeem a human, user needs to have at least one Genesis Token.
     * @param _category Genesis token category between 1 and 10.
     */
    function redeemAndMintGenesis(
        uint256 _category,
        uint256 _amount
    ) external;

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        bytes memory data
    ) external;

    function balanceOf(address owner) external returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) external returns (uint256);
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;
}