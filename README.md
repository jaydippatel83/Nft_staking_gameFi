# Advanced Sample Hardhat Project

This project demonstrates an advanced Hardhat use case, integrating other tools commonly used alongside Hardhat in the ecosystem.

The project comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts. It also comes with a variety of other tools, preconfigured to work with the project code.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
npx hardhat help
REPORT_GAS=true npx hardhat test
npx hardhat coverage
npx hardhat run scripts/deploy.ts
TS_NODE_FILES=true npx ts-node scripts/deploy.ts
npx eslint '**/*.{js,ts}'
npx eslint '**/*.{js,ts}' --fix
npx prettier '**/*.{json,sol,md}' --check
npx prettier '**/*.{json,sol,md}' --write
npx solhint 'contracts/**/*.sol'
npx solhint 'contracts/**/*.sol' --fix


npx hardhat getTokenBalance --network localhost --token-contract 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512

npx hardhat stake  --network localhost --token-contract 0xa513E6E4b8f2a923D98304ec87F64353C4D5C853  --token-ids 1 

npx hardhat unstake  --network localhost --token-contract 0xa513E6E4b8f2a923D98304ec87F64353C4D5C853 --token-ids 1 

npx hardhat claim   --network localhost --token-contract 0xa513E6E4b8f2a923D98304ec87F64353C4D5C853   

npx hardhat getNFTBalance --network localhost --nft-contract 0x0165878A594ca255338adfa4d48449f69242Eb8F 

npx hardhat getTokenBalance --network localhost --token-contract 0xa513E6E4b8f2a923D98304ec87F64353C4D5C853
 

npx hardhat stake  --network localhost --token-contract 0xa513E6E4b8f2a923D98304ec87F64353C4D5C853 --token-ids 1,2
 
 
npx hardhat getNFTBalance --network localhost --nft-contract 0x0165878A594ca255338adfa4d48449f69242Eb8F    
 

npx hardhat unstake  --network localhost --token-contract 0xa513E6E4b8f2a923D98304ec87F64353C4D5C853 --token-ids 2 

npx hardhat getNFTBalance --network localhost --nft-contract 0x0165878A594ca255338adfa4d48449f69242Eb8F 

npx hardhat getTokenBalance --network localhost --token-contract  

npx hardhat claim   --network localhost --token-contract  
 
npx hardhat getTokenBalance --network localhost --token-contract 0xa513E6E4b8f2a923D98304ec87F64353C4D5C853
 
```

# Etherscan verification

To try out Etherscan verification, you first need to deploy a contract to an Ethereum network that's supported by Etherscan, such as Ropsten.

In this project, copy the .env.example file to a file named .env, and then edit it to fill in the details. Enter your Etherscan API key, your Ropsten node URL (eg from Alchemy), and the private key of the account which will send the deployment transaction. With a valid .env file in place, first deploy your contract:

```shell
hardhat run --network ropsten scripts/deploy.ts
```

Then, copy the deployment address and paste it in to replace `DEPLOYED_CONTRACT_ADDRESS` in this command:

```shell
npx hardhat verify --network ropsten DEPLOYED_CONTRACT_ADDRESS "Hello, Hardhat!"
```

# Performance optimizations

For faster runs of your tests and scripts, consider skipping ts-node's type checking by setting the environment variable `TS_NODE_TRANSPILE_ONLY` to `1` in hardhat's environment. For more details see [the documentation](https://hardhat.org/guides/typescript.html#performance-optimizations).
