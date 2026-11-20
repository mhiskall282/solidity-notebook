// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract UserRegistry {
    struct User {
        uint256 id;
        string name;
        string email;
        bool isActive;
        uint256 createdAt;
        uint256 updatedAt;
    }
    
    mapping(uint256 => User) public users;
    mapping(address => uint256) public addressToUserId;
    uint256 public userCount;
    
    event UserCreated(uint256 indexed userId, string name, address indexed creator);
    event UserUpdated(uint256 indexed userId, string name);
    event UserDeleted(uint256 indexed userId);
    event UserActivated(uint256 indexed userId);
    
    function createUser(string memory _name, string memory _email) external returns (uint256) {
        require(bytes(_name).length > 0, "Name required");
        require(addressToUserId[msg.sender] == 0, "User exists");
        
        userCount++;
        users[userCount] = User({
            id: userCount,
            name: _name,
            email: _email,
            isActive: true,
            createdAt: block.timestamp,
            updatedAt: block.timestamp
        });
        
        addressToUserId[msg.sender] = userCount;
        emit UserCreated(userCount, _name, msg.sender);
        return userCount;
    }
    
    function updateUser(uint256 _userId, string memory _name, string memory _email) external {
        require(_userId > 0 && _userId <= userCount, "Invalid user");
        require(users[_userId].isActive, "User inactive");
        
        users[_userId].name = _name;
        users[_userId].email = _email;
        users[_userId].updatedAt = block.timestamp;
        
        emit UserUpdated(_userId, _name);
    }
    
    function deleteUser(uint256 _userId) external {
        require(_userId > 0 && _userId <= userCount, "Invalid user");
        users[_userId].isActive = false;
        users[_userId].updatedAt = block.timestamp;
        emit UserDeleted(_userId);
    }
    
    function getUser(uint256 _userId) external view returns (User memory) {
        require(_userId > 0 && _userId <= userCount, "Invalid user");
        return users[_userId];
    }
    
    function getAllActiveUsers() external view returns (User[] memory) {
        uint256 activeCount = 0;
        for (uint256 i = 1; i <= userCount; i++) {
            if (users[i].isActive) activeCount++;
        }
        
        User[] memory activeUsers = new User[](activeCount);
        uint256 index = 0;
        for (uint256 i = 1; i <= userCount; i++) {
            if (users[i].isActive) {
                activeUsers[index] = users[i];
                index++;
            }
        }
        return activeUsers;
    }
}
