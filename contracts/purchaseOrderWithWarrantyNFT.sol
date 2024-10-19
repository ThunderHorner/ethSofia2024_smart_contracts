// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract PurchaseOrderWithWarrantyNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Purchase {
        string productId;
        string productName;
        string currency;
        string serialNumber;
        uint256 price;
        address buyer;
        string sellerName;
        address seller;
        uint256 purchaseDate;
        string expirationDate;
    }

    mapping(uint256 => Purchase) private purchases;

    event PurchaseCreated(
        uint256 tokenId,
        string productId,
        string productName,
        string currency,
        string serialNumber,
        uint256 price,
        address buyer,
        string sellerName,
        address seller,
        uint256 purchaseDate,
        string expirationDate
    );

    constructor() ERC721("PurchaseOrderNFT", "PONFT") {}

    function createPurchase(
        string memory _productId,
        string memory productName,
        string memory currency,
        string memory serialNumber,
        uint256 _price,
        address _buyer,
        string memory sellerName,
        string memory expirationDate
    ) public returns (uint256) {
        require(_buyer != address(0), "Invalid buyer address");
        require(bytes(_productId).length > 0, "Product ID cannot be empty");
        require(bytes(serialNumber).length > 0, "Serial number cannot be empty");
        require(_price > 0, "Price must be greater than zero");

        // Mint the NFT
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        _safeMint(_buyer, newTokenId);

        // Create the purchase record
        purchases[newTokenId] = Purchase(
            _productId,
            productName,
            currency,
            serialNumber,
            _price,
            _buyer,
            sellerName,
            msg.sender,
            block.timestamp,
            expirationDate
        );

        emit PurchaseCreated(
            newTokenId,
            _productId,
            productName,
            currency,
            serialNumber,
            _price,
            _buyer,
            sellerName,
            msg.sender,
            block.timestamp,
            expirationDate
        );

        return newTokenId;
    }

    function getPurchaseByTokenId(uint256 tokenId) public view returns (Purchase memory) {
        require(_exists(tokenId), "Token does not exist");
        return purchases[tokenId];
    }

    function getPurchasesByOwner(address owner) public view returns (Purchase[] memory) {
        uint256 balance = balanceOf(owner);
        Purchase[] memory result = new Purchase[](balance);

        uint256 index = 0;
        for (uint256 tokenId = 1; tokenId <= _tokenIds.current(); tokenId++) {
            if (ownerOf(tokenId) == owner) {
                result[index] = purchases[tokenId];
                index++;
            }
        }

        return result;
    }
}
