// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./interfaces/IERC721Metadata.sol";
import "./ERC165.sol";

contract ERC721Metadata is IERC721Metadata, ERC165 {
    string private name;
    string private symbol;

    constructor(string memory _name, string memory _symbol) {
        _registerInterface(
            bytes4(
                keccak256("getName(bytes4)") ^ keccak256("getSymbol(bytes4)")
            )
        );

        name = _name;
        symbol = _symbol;
    }

    function getName() external view override returns (string memory) {
        return name;
    }

    function getSymbol() external view override returns (string memory) {
        return symbol;
    }
}
