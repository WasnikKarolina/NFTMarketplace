// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract Market {
    address public user;

    constructor(address _user) {
        user = _user;
    }
    struct NFT {
        address owner;
        uint256 price;
        bool isOnMarket;
    }
//    these mappings to be linked to a source of available on the market NFTs (we use NFTrepo.json as an instance)
    mapping(uint256 => NFT) public nfts;

    event NFTOnMarket(uint256 tokenId, uint256 price);
    event NFTSold(uint256 tokenId, address buyer);

    function setPrice(uint256 tokenId, uint256 price) external {
        require(user == nfts[tokenId].owner, "You are not the owner of this NFT");
        nfts[tokenId].price = price;
    }

    function putOnMarket(uint256 tokenId) external {
        require(user == nfts[tokenId].owner, "You are not the owner of this NFT");
        nfts[tokenId].isOnMarket = true;
        emit NFTOnMarket(tokenId, nfts[tokenId].price);
    }

    function buy(uint256 tokenId) external payable {
        require(nfts[tokenId].isOnMarket, "This NFT is not on the market");
        require(msg.value >= nfts[tokenId].price, "Insufficient funds to buy this NFT");

        address payable currentOwner = payable(nfts[tokenId].owner);
        currentOwner.transfer(msg.value);

        nfts[tokenId].isOnMarket = false;
        nfts[tokenId].owner = user;

        emit NFTSold(tokenId, user);
    }
    function getNFT(uint256 tokenId) external view returns (NFT memory) {
        return nfts[tokenId];
    }
    function addNFT(uint256 tokenId, uint256 price, address owner, bool isOnMarket) external {
        nfts[tokenId] = NFT(owner, price, isOnMarket);
    }
}

