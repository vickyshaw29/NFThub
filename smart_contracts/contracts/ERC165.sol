// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./interfaces/IERC165.sol";

contract ERC165 is IERC165{
    mapping(bytes4=>bool) private _supportedInterfaces;
    function supportsInterface(bytes4 interfaceId) external view override returns(bool){
        return _supportedInterfaces[interfaceId];
    }
    function _registerInterface(bytes4 interfaceId)internal {
        require(interfaceId!=0xffffffff,"ERC165: invalid interface id");
        _supportedInterfaces[interfaceId]=true;
    }
}