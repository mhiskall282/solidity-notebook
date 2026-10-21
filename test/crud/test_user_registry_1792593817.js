const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("UserRegistry CRUD Tests", function () {
  let registry, owner, user1, user2;
  
  beforeEach(async function () {
    [owner, user1, user2] = await ethers.getSigners();
    const Registry = await ethers.getContractFactory("UserRegistry");
    registry = await Registry.deploy();
  });
  
  it("CREATE: Should create new user", async function () {
    await registry.connect(user1).createUser("Alice", "alice@test.com");
    const user = await registry.getUser(1);
    expect(user.name).to.equal("Alice");
    expect(user.isActive).to.be.true;
  });
  
  it("READ: Should retrieve user data", async function () {
    await registry.connect(user1).createUser("Bob", "bob@test.com");
    const user = await registry.getUser(1);
    expect(user.email).to.equal("bob@test.com");
  });
  
  it("UPDATE: Should update user info", async function () {
    await registry.connect(user1).createUser("Charlie", "charlie@test.com");
    await registry.connect(user1).updateUser(1, "Charles", "charles@test.com");
    const user = await registry.getUser(1);
    expect(user.name).to.equal("Charles");
  });
  
  it("DELETE: Should soft delete user", async function () {
    await registry.connect(user1).createUser("David", "david@test.com");
    await registry.deleteUser(1);
    const user = await registry.getUser(1);
    expect(user.isActive).to.be.false;
  });
});
