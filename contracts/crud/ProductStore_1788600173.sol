// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ProductStore {
    struct Product {
        uint256 id;
        string name;
        uint256 price;
        uint256 stock;
        address owner;
        bool isAvailable;
    }
    
    mapping(uint256 => Product) public products;
    uint256 public productCount;
    
    event ProductAdded(uint256 indexed productId, string name, uint256 price);
    event ProductUpdated(uint256 indexed productId);
    event ProductPurchased(uint256 indexed productId, address buyer, uint256 amount);
    
    function addProduct(string memory _name, uint256 _price, uint256 _stock) external returns (uint256) {
        productCount++;
        products[productCount] = Product({
            id: productCount,
            name: _name,
            price: _price,
            stock: _stock,
            owner: msg.sender,
            isAvailable: true
        });
        emit ProductAdded(productCount, _name, _price);
        return productCount;
    }
    
    function updateProduct(uint256 _id, uint256 _price, uint256 _stock) external {
        require(products[_id].owner == msg.sender, "Not owner");
        products[_id].price = _price;
        products[_id].stock = _stock;
        emit ProductUpdated(_id);
    }
    
    function purchaseProduct(uint256 _id, uint256 _quantity) external payable {
        Product storage product = products[_id];
        require(product.isAvailable, "Not available");
        require(product.stock >= _quantity, "Insufficient stock");
        require(msg.value >= product.price * _quantity, "Insufficient payment");
        
        product.stock -= _quantity;
        emit ProductPurchased(_id, msg.sender, _quantity);
        
        payable(product.owner).transfer(msg.value);
    }
}
