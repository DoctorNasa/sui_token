
# Deploy Token on SUI Chain using Move 2024

## Clound you please give me a Star! :star: :star: :star:

## Overview
This README provides a guide on how to deploy a token on the Sui blockchain using the updated Move 2024 language features.

## Requirements
- Sui client (Make sure it's the latest version to avoid compatibility issues)
- Move 2024 compiler

## Step-by-Step Guide

### 1. Create a New Sui Wallet
Create a new address that will act as your wallet on the Sui network.
```bash
sui client new-address ed25519
```

### 2. Create a New Move Package
Initialize a new Move package to start your project.
```bash
sui move new my_first_package
```

### 3. Update Your Move.toml
Ensure your `Move.toml` specifies the 2024 edition:
```toml
edition = "2024.beta"
```

### 4. Develop Your Token Contract
Implement your token logic in Move. Below is a basic example of a token module using Move 2024 features:

```move
module firoll::firoll {
    use std::option;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct FIROLL has drop {}

    fun init(witness: FIROLL, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 9, b"PE", b"FIROLL", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx))
    }

    public entry fun mint(
        treasury: &mut coin::TreasuryCap<FIROLL>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury, amount, recipient, ctx)
    }
}
```

### 5. Publish Your Package
Publish your package to the Sui blockchain.
```bash
sui client publish --gas-budget 100000000 --skip-dependency-verification
```

### 6. Mint Tokens
Execute the mint function to issue new tokens to a specified address.
```bash
sui client call --package <PACKAGE_ID> --module firoll --function mint --args <TREASURYCAP_ID> 1000000 <RECIPIENT_ADDRESS> --gas-budget 300000000
```

### 7. Handling Updates and Migrations
To update your Move code or migrate to a newer version, use:
```bash
sui move migrate
```

## Troubleshooting
- Ensure your client and server versions match.
- Check for network protocol compatibility.

For more detailed commands and outputs, refer to the Move documentation and Sui developer resources.

## Please Give Me a Star! :star: :star: :star:
If you find this repository useful, please consider giving it a star on GitHub. Your support is a big thank you to me and motivates me to continue developing and sharing more great content!

:star: Star us on GitHub — it helps!