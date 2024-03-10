// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

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
    mapping(address => uint256[]) public userNFTs;

    event NFTOnMarket(uint256 tokenId, uint256 price);
    event NFTSold(uint256 tokenId, address buyer);

    function setPrice(uint256 tokenId, uint256 price) external {
//        additional security checks. Disabled to be deployed in Remix
        require(msg.user == nfts[tokenId].owner, "You are not the owner of this NFT");
        nfts[tokenId].price = price;
    }

    function putOnMarket(uint256 tokenId) external {
//        additional security checks. Disabled to be deployed in Remix
        require(msg.user == nfts[tokenId].owner, "You are not the owner of this NFT");
        nfts[tokenId].isOnMarket = true;
        emit NFTOnMarket(tokenId, nfts[tokenId].price);
    }

    function buy(uint256 tokenId) external payable {
        require(nfts[tokenId].isOnMarket, "This NFT is not on the market");
        require(msg.value >= nfts[tokenId].price, "Insufficient funds to buy this NFT");

        address payable currentOwner = payable(nfts[tokenId].owner);
        currentOwner.transfer(msg.value);

        nfts[tokenId].isOnMarket = false;
        nfts[tokenId].owner = msg.user;
        userNFTs[msg.user].push(tokenId);

        emit NFTSold(tokenId, msg.user);
    }
    function getPrice(uint256 tokenId) external view returns(uint256){
        return nfts[tokenId].price;
    }
    function getBoolean(uint256 tokenId) external view returns(bool){
        return nfts[tokenId].isOnMarket;
    }
    function getNFT(uint256 tokenId) external view returns (NFT memory) {
        return nfts[tokenId];
    }
}

