# ETH Sofia 2024 smart contracts 
___
This repo contains our smart contracts and deployment scripts.
The are deployed onto our internal node in so we can develop and test everything before putting it on the network

```shell
npm ci
npx hardhat run scripts/deploy.js --network elunesoft --show-stack-traces
```
PurchaseOrder deployed to: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
PurchaseOrderWithWarranty deployed to: 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
PurchaseOrderWithWarrantyNFT deployed to: 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9
