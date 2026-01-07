// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract InitialContract {
    uint256 public counter;
    
    function increment() external {
        counter++;
    }
    
    function getCounter() external view returns (uint256) {
        return counter;
    }
}
