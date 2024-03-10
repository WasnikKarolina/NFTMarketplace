// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

//contract Market {
//    struct NFTToken {
//        uint tokenId;
//        address owner;
//        uint256 price;
//        string metadataURI; // stores additional data like photo, description, date of creation etc
////        address creator;
//        string tokenURI; // link to an actual asset
//    }
//    constructor(){
//
//    }
//
//}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Market {
    struct NFT {
        address owner;
        uint256 price;
        bool isOnMarket;
    }

    mapping(uint256 => NFT) public nfts;
    mapping(address => uint256[]) public userNFTs;

    event NFTOnMarket(uint256 tokenId, uint256 price);
    event NFTSold(uint256 tokenId, address buyer);

    function setPrice(uint256 tokenId, uint256 price) external {
        require(msg.sender == nfts[tokenId].owner, "You are not the owner of this NFT");
        nfts[tokenId].price = price;
    }

    function putOnMarket(uint256 tokenId) external {
        require(msg.sender == nfts[tokenId].owner, "You are not the owner of this NFT");
        nfts[tokenId].isOnMarket = true;
        emit NFTOnMarket(tokenId, nfts[tokenId].price);
    }

    function buy(uint256 tokenId) external payable {
        require(nfts[tokenId].isOnMarket, "This NFT is not on the market");
        require(msg.value >= nfts[tokenId].price, "Insufficient funds to buy this NFT");

        address payable currentOwner = payable(nfts[tokenId].owner);
        currentOwner.transfer(msg.value);

        nfts[tokenId].isOnMarket = false;
        nfts[tokenId].owner = msg.sender;
        userNFTs[msg.sender].push(tokenId);

        emit NFTSold(tokenId, msg.sender);
    }
}

