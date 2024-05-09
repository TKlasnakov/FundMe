-include .env

deploy-sepolia:
	forge script script/DeployFoundMe.s.sol:DeployFoundMe -rpc-url $SEPOLIA_URL --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)

deploy-mainnet: 
	forge script script/DeployFoundMe.s.sol:DeployFoundMe -rpc-url $MAINNET_URL --private-key $( ) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)