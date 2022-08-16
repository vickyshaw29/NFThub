// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ERC721Connector.sol";

contract Birdz is ERC721Connector {
    constructor() ERC721Connector("Birdz", "BZ") {}
}
