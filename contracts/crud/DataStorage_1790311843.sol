// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DataStorage {
    struct Record {
        uint256 id;
        bytes32 dataHash;
        string metadata;
        address creator;
        uint256 timestamp;
        bool isValid;
    }
    
    mapping(uint256 => Record) public records;
    mapping(address => uint256[]) public userRecords;
    uint256 public recordCount;
    
    event RecordCreated(uint256 indexed recordId, bytes32 dataHash, address creator);
    event RecordUpdated(uint256 indexed recordId);
    event RecordInvalidated(uint256 indexed recordId);
    
    function createRecord(bytes32 _dataHash, string memory _metadata) external returns (uint256) {
        recordCount++;
        records[recordCount] = Record({
            id: recordCount,
            dataHash: _dataHash,
            metadata: _metadata,
            creator: msg.sender,
            timestamp: block.timestamp,
            isValid: true
        });
        
        userRecords[msg.sender].push(recordCount);
        emit RecordCreated(recordCount, _dataHash, msg.sender);
        return recordCount;
    }
    
    function updateRecord(uint256 _recordId, string memory _metadata) external {
        require(records[_recordId].creator == msg.sender, "Not creator");
        require(records[_recordId].isValid, "Record invalid");
        records[_recordId].metadata = _metadata;
        emit RecordUpdated(_recordId);
    }
    
    function invalidateRecord(uint256 _recordId) external {
        require(records[_recordId].creator == msg.sender, "Not creator");
        records[_recordId].isValid = false;
        emit RecordInvalidated(_recordId);
    }
    
    function getUserRecords(address _user) external view returns (uint256[] memory) {
        return userRecords[_user];
    }
}
