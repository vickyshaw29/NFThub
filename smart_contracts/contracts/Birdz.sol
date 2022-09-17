// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ERC721Connector.sol";

contract Birdz is ERC721Connector {
    
    constructor() ERC721Connector("Birdz", "BZ") {}
    //array to store our NFTs 
    string[] public birdzCollections;
    mapping(string=>bool) public birdExists;
    function mint(string memory _bird)public {
        require(!birdExists[_bird],"Already minted");
        birdzCollections.push(_bird);
        uint _id=birdzCollections.length-1;
        _mint(msg.sender,_id);
        birdExists[_bird]=true;
    } 
}
