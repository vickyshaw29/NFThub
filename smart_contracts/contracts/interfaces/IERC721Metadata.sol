// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721Metadata /* is ERC721 */ {
    /// @notice A descriptive name for a collection of NFTs in this contract
    function getName() external view returns (string memory _name);

    /// @notice An abbreviated name for NFTs in this contract
    function getSymbol() external view returns (string memory _symbol);

    // function tokenURI(uint256 _tokenId) external view returns (string memory);
}