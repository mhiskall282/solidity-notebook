// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract TaskManager {
    enum TaskStatus { Pending, InProgress, Completed, Cancelled }
    
    struct Task {
        uint256 id;
        string title;
        string description;
        TaskStatus status;
        address assignedTo;
        uint256 deadline;
        uint256 createdAt;
    }
    
    mapping(uint256 => Task) public tasks;
    uint256 public taskCount;
    
    event TaskCreated(uint256 indexed taskId, string title, address assignedTo);
    event TaskUpdated(uint256 indexed taskId, TaskStatus status);
    event TaskCompleted(uint256 indexed taskId);
    
    function createTask(string memory _title, string memory _desc, address _assignee, uint256 _deadline) 
        external returns (uint256) {
        taskCount++;
        tasks[taskCount] = Task({
            id: taskCount,
            title: _title,
            description: _desc,
            status: TaskStatus.Pending,
            assignedTo: _assignee,
            deadline: _deadline,
            createdAt: block.timestamp
        });
        emit TaskCreated(taskCount, _title, _assignee);
        return taskCount;
    }
    
    function updateTaskStatus(uint256 _taskId, TaskStatus _status) external {
        require(_taskId <= taskCount, "Invalid task");
        tasks[_taskId].status = _status;
        emit TaskUpdated(_taskId, _status);
        
        if (_status == TaskStatus.Completed) {
            emit TaskCompleted(_taskId);
        }
    }
    
    function getTask(uint256 _taskId) external view returns (Task memory) {
        return tasks[_taskId];
    }
    
    function getTasksByStatus(TaskStatus _status) external view returns (Task[] memory) {
        uint256 count = 0;
        for (uint256 i = 1; i <= taskCount; i++) {
            if (tasks[i].status == _status) count++;
        }
        
        Task[] memory result = new Task[](count);
        uint256 index = 0;
        for (uint256 i = 1; i <= taskCount; i++) {
            if (tasks[i].status == _status) {
                result[index] = tasks[i];
                index++;
            }
        }
        return result;
    }
}
