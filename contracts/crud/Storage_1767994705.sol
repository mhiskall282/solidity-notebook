// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Storage
 * @dev Auto-generated contract - 2026-01-09-21-38
 */
contract Storage_1767994705 {
    uint256 public id;
    address public creator;
    string public name;
    bool public isActive;
    
    mapping(address => bool) public authorized;
    
    event Created(uint256 id, address creator);
    event StatusChanged(bool isActive);
    event AuthorizationUpdated(address indexed user, bool status);
    
    constructor() {
        creator = msg.sender;
        isActive = true;
        authorized[msg.sender] = true;
        emit Created(block.timestamp, msg.sender);
    }
    
    modifier onlyAuthorized() {
        require(authorized[msg.sender], "Not authorized");
        _;
    }
    
    function setName(string memory _name) external onlyAuthorized {
        name = _name;
    }
    
    function toggleActive() external onlyAuthorized {
        isActive = !isActive;
        emit StatusChanged(isActive);
    }
    
    function authorize(address _user, bool _status) external onlyAuthorized {
        authorized[_user] = _status;
        emit AuthorizationUpdated(_user, _status);
    }
    
    function getInfo() external view returns (
        uint256,
        address,
        string memory,
        bool
    ) {
        return (id, creator, name, isActive);
    }
}
