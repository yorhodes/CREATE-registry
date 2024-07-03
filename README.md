## CREATE Registry

This repository contains the smart contract source code for the CREATE Registry. 

This registry provides a trustless mapping from deployed contract addresses to their respective deployer addresses. 

This is useful for granting funds or permissions to developers based on the contracts they have deployed.

## Usage

Get the CREATE transaction hash
```shell
curl https://api.etherscan.io/api\
?module\=contract\
&action\=getcontractcreation\
&contractaddresses\=0xc005dc82818d67AF737725bD4bf75435d065D239\
&apikey\=YourApiKeyToken \
| jq '.result[0].txHash'
```

Get relevant transaction fields
```shell
cast tx 0x3da029916b4f040bfe0670f0df716a770bc20f4cdabc20f144bd526d5010fc54 --json | jq '.from,.nonce'
```

Left pad nonce to even length
```shell
"0x6a9" => "0x06a9"
```

RLP encode from and nonce
```shell
cast to-rlp '["0xa7eccdb9be08178f896c26b7bbd8c3d4e844d9ba","0x06a9"]'
```

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```
