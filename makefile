# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

script-mainnet:
    forge script script/MassMint.s.sol:MassMintScript --ffi --rpc-url ${MAINNET_RPC_URL}  --private-key ${PRIVATE_KEY} --broadcast --verify --etherscan-api-key ${ETHERSCAN_KEY} -vvvv