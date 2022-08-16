// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721{
    mapping(uint=>address)private tokenOwner;
    mapping(address=>uint) private ownedToken;

    function _exists(uint256 tokenId)internal view returns(bool){
        address owner =tokenOwner[tokenId];
        return owner!=address(0);
    }
    function _mint(address to,uint tokenId)internal{
        require(to!=address(0),"Invalid address");
        require(!_exists(tokenId),"token already minted");
        tokenOwner[tokenId]=to;
        ownedToken[to]+=1;
    }
}