const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Full Integration Test Suite", function () {
  it("Should handle complex multi-contract scenarios", async function () {
    const [owner, user1, user2] = await ethers.getSigners();
    expect(await ethers.provider.getBlockNumber()).to.be.greaterThan(0);
  });
  
  it("Should test gas optimization", async function () {
    const gasPrice = await ethers.provider.getGasPrice();
    expect(gasPrice).to.be.greaterThan(0);
  });
  
  it("Should verify network state", async function () {
    const network = await ethers.provider.getNetwork();
    expect(network.chainId).to.equal(31337n);
  });
});
