# ETH Sofia 2024 smart contracts 
___
This repo contains our smart contracts and deployment scripts.
The are deployed onto our internal node in so we can develop and test everything before putting it on the network

```shell
npm ci
npx hardhat run scripts/deploy.js --network elunesoft --show-stack-traces
```
PurchaseOrder deployed to: 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9
PurchaseOrderWithWarranty deployed to: 0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9
PurchaseOrderWithWarrantyNFT deployed to: 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707
