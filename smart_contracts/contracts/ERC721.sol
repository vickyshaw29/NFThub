// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721{
    event Transfer(address indexed from , address indexed to,uint256 indexed tokenId);
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
        emit Transfer(address(0), to, tokenId);
    }
    function balanceOf(address owner)public view returns(uint256){
        require(owner!=address(0),"Invalid owner");
        return ownedToken[owner];
    }
    function ownerOf(uint256 tokenId)external view returns(address){
        address owner = tokenOwner[tokenId];
        require(owner!=address(0),"Invalid owner");
        return owner;
    }
}