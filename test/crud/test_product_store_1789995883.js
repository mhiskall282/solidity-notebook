const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ProductStore CRUD Operations", function () {
  let store, owner, seller, buyer;
  
  beforeEach(async function () {
    [owner, seller, buyer] = await ethers.getSigners();
    const Store = await ethers.getContractFactory("ProductStore");
    store = await Store.deploy();
  });
  
  it("Should add products", async function () {
    await store.connect(seller).addProduct("Laptop", ethers.parseEther("1"), 10);
    const product = await store.products(1);
    expect(product.name).to.equal("Laptop");
  });
  
  it("Should update product details", async function () {
    await store.connect(seller).addProduct("Phone", ethers.parseEther("0.5"), 20);
    await store.connect(seller).updateProduct(1, ethers.parseEther("0.6"), 15);
    const product = await store.products(1);
    expect(product.price).to.equal(ethers.parseEther("0.6"));
  });
});
