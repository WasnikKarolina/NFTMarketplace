const Web3 = require('web3');
const MarketABI = require('./MarketABI.json'); // Replace with the ABI of your Market contract
const marketContractAddress = '0x123...'; // Replace with the address of your Market contract
const nfts = require('./NFTrepo.json'); // Load the JSON array of NFTs
const AccountAddress = "0x3a3E804929EcdcE6B880a2A05516526C94B8296C";

const web3 = new Web3('https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID');


const marketContract = new web3.eth.Contract(MarketABI, marketContractAddress);

// Function to add NFTs from the JSON array to the Market contract
async function addNFTsToMarket() {
    for (const nft of nfts) {
        await marketContract.methods.setPrice(nft.tokenId, nft.price).send({ from: accountAddress, gas: 3000000 });
        await marketContract.methods.putOnMarket(nft.tokenId).send({ from: accountAddress, gas: 3000000 });
    }
}

// Call the function to add NFTs to the Market contract
addNFTsToMarket().then(() => {
    console.log('NFTs added to Market contract successfully');
}).catch((error) => {
    console.error('Error adding NFTs to Market contract:', error);
});
