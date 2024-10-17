// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PurchaseOrder {
    struct Purchase {
        string productId;
        string productName;
        string currency;
        uint256 price;
        address buyer;
        string  sellerName;
        address seller;
        uint256 purchaseDate;
    }

    mapping(address => mapping(uint256 => Purchase)) private purchases;
    mapping(address => uint256) private purchaseCounts;

    event PurchaseCreated(uint256 purchaseId, string productId, string productName, string currency, uint256 price, address buyer, string sellerName ,address seller, uint256 purchaseDate);

    function createPurchase(string memory _productId, string memory productName, string memory currency, uint256 _price, address _buyer) public {
        require(_buyer != address(0), "Invalid buyer address");
        require(bytes(_productId).length > 0, "Product ID cannot be empty");
        require(_price > 0, "Price must be greater than zero");

        uint256 purchaseId = ++purchaseCounts[msg.sender];
        purchases[msg.sender][purchaseId] = Purchase(_productId, productName, currency, _price, _buyer, msg.sender, block.timestamp);

        emit PurchaseCreated(purchaseId, _productId, productName, currency, _price, _buyer, msg.sender, block.timestamp);
    }

    function getPurchasesByBuyer(address _buyer) public view returns (Purchase[] memory) {
        require(_buyer != address(0), "Invalid buyer address");

        uint256 count = purchaseCounts[msg.sender];
        Purchase[] memory result = new Purchase[](count);
        uint256 resultIndex = 0;

        for (uint256 i = 1; i <= count; i++) {
            if (purchases[msg.sender][i].buyer == _buyer) {
                result[resultIndex] = purchases[msg.sender][i];
                resultIndex++;
            }
        }
        assembly {
            mstore(result, resultIndex)
        }
        return result;
    }

    function getPurchaseCount() public view returns (uint256) {
        return purchaseCounts[msg.sender];
    }
}