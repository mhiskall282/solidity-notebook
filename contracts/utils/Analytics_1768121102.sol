// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Analytics {
    struct Metric {
        string name;
        uint256 value;
        uint256 timestamp;
    }
    
    mapping(bytes32 => Metric[]) public metrics;
    
    event MetricRecorded(bytes32 indexed metricKey, uint256 value, uint256 timestamp);
    
    function recordMetric(string memory _name, uint256 _value) external {
        bytes32 key = keccak256(abi.encodePacked(_name));
        metrics[key].push(Metric({
            name: _name,
            value: _value,
            timestamp: block.timestamp
        }));
        emit MetricRecorded(key, _value, block.timestamp);
    }
    
    function getMetrics(string memory _name) external view returns (Metric[] memory) {
        bytes32 key = keccak256(abi.encodePacked(_name));
        return metrics[key];
    }
    
    function getLatestMetric(string memory _name) external view returns (Metric memory) {
        bytes32 key = keccak256(abi.encodePacked(_name));
        require(metrics[key].length > 0, "No metrics found");
        return metrics[key][metrics[key].length - 1];
    }
}
