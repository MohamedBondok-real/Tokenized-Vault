# Tokenized Vault

A simple **ERC-20 Tokenized Vault** built with Solidity.

The vault allows users to deposit ERC-20 tokens and receive vault shares representing their proportional ownership of the assets held by the vault. Users can later withdraw their underlying tokens by redeeming their shares.

## Overview

The vault uses a share-based accounting system:

* Users deposit ERC-20 tokens into the vault.
* The vault mints shares proportional to the deposited amount.
* Shares represent a user's ownership of the vault's underlying assets.
* Users can withdraw tokens by burning their shares.
* The value of each share changes as the vault's token balance changes.

## How It Works

### Deposit

When a user deposits tokens:

* If the vault is empty, the user receives shares equal to the deposited amount.
* Otherwise, shares are calculated proportionally based on the vault's current assets and total shares.

```text
shares = amount × totalSupply / vaultAssets
```

The vault then mints the calculated shares to the depositor.

### Withdraw

When a user withdraws:

```text
amount = shares × vaultAssets / totalSupply
```

The calculated amount of underlying ERC-20 tokens is transferred to the user, and their shares are burned.

## Contract

### `Vault`

The main contract manages the deposited ERC-20 token and the corresponding vault shares.

#### State Variables

```solidity
IERC20 public immutable token;
uint256 public totalSupply;
mapping(address => uint256) public balanceOf;
```

* `token` — The ERC-20 token managed by the vault.
* `totalSupply` — Total number of vault shares.
* `balanceOf` — Shares owned by each address.

#### Main Functions

### `deposit(uint256 _amount)`

Deposits ERC-20 tokens into the vault and mints the corresponding number of shares to the sender.

### `withdraw(uint256 _shares)`

Burns the user's shares and transfers the proportional amount of underlying ERC-20 tokens back to the user.

## Technology Stack

* Solidity `^0.8.31`
* Ethereum / EVM
* ERC-20
* OpenZeppelin IERC20 interface

## Project Structure

```text
.
└── TokenizedVault.sol
```

## Security Notes

This project is intended as a learning implementation of tokenized vault mechanics.

Before using a vault like this in production, additional considerations should be addressed, including:

* Safe ERC-20 transfer handling
* Reentrancy protection
* Token behavior compatibility
* Rounding and precision
* Comprehensive testing
* Access control where required
* Integration with production-grade vault standards

## License

This project is licensed under the MIT License.
