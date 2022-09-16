// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ERC165.sol";
import "./interfaces/IERC721.sol";

contract ERC721 is ERC165,IERC721{
    //mapping from tokenId to the owner
    mapping(uint=>address)private tokenOwner;
    //mapping from owner to number of owned tokens
    mapping(address=>uint) private ownedToken;
    //mapping from tokenId to approved addresses 
    mapping(uint256=>address) private tokenApprovals;

     constructor() {
        _registerInterface(
            bytes4(
                keccak256("balanceOf(bytes4)") ^
                    keccak256("ownerOf(bytes4)") ^
                    keccak256("transferFrom(bytes4)")
            )
        );
    }

    function _exists(uint256 tokenId)internal view returns(bool){
        address owner =tokenOwner[tokenId];
        return owner!=address(0);
    }
    function _mint(address to,uint tokenId)internal virtual{
        require(to!=address(0),"Invalid address");
        require(!_exists(tokenId),"token already minted");
        tokenOwner[tokenId]=to;
        ownedToken[to]+=1;
        emit Transfer(address(0), to, tokenId);
    }
    function balanceOf(address owner)public view override returns(uint256){
        require(owner!=address(0),"Invalid owner");
        return ownedToken[owner];
    }
    function ownerOf(uint256 tokenId)public view override returns(address){
        address owner = tokenOwner[tokenId];
        require(owner!=address(0),"Invalid owner");
        return owner;
    }

    //transfer 
    function _transferFrom(address _from,address _to,uint256 tokenId)internal {
        require(_to!=address(0),"Invalid address");
        require(ownerOf(tokenId)==_from,"You dont have tokens to transfer");
        ownedToken[_from]-=1;
        ownedToken[_to]+=1;
        tokenOwner[tokenId]=_to;
        emit Transfer(_from, _to, tokenId);
    }
    function transferFrom(address _from,address _to,uint256 tokenId)public override payable{
        _transferFrom(_from, _to, tokenId);
    }
    function isApprovedOrOwner(address spender,uint256 tokenId)public view returns(bool){
        //check if the spender is the owner of the token
        address owner = ownerOf(tokenId);
        //check if the spender is approved for the token
        //getApproved(tokenId) returns the address of the approved spender to be implemented ;
        return (spender==owner );
    }
}