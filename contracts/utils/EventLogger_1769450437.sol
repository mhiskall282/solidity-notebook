// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract EventLogger {
    struct Log {
        address sender;
        string action;
        bytes data;
        uint256 timestamp;
    }
    
    Log[] public logs;
    
    event ActionLogged(address indexed sender, string action, uint256 timestamp);
    
    function logAction(string memory _action, bytes memory _data) external {
        logs.push(Log({
            sender: msg.sender,
            action: _action,
            data: _data,
            timestamp: block.timestamp
        }));
        emit ActionLogged(msg.sender, _action, block.timestamp);
    }
    
    function getLogCount() external view returns (uint256) {
        return logs.length;
    }
    
    function getLog(uint256 _index) external view returns (Log memory) {
        require(_index < logs.length, "Invalid index");
        return logs[_index];
    }
    
    function getRecentLogs(uint256 _count) external view returns (Log[] memory) {
        uint256 start = logs.length > _count ? logs.length - _count : 0;
        uint256 length = logs.length - start;
        
        Log[] memory recentLogs = new Log[](length);
        for (uint256 i = 0; i < length; i++) {
            recentLogs[i] = logs[start + i];
        }
        return recentLogs;
    }
}
