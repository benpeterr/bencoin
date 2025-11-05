# BenCoin (bencoin)

BenCoin is a fungible token implemented in Clarity, designed to follow the SIP-010 interface shape (name, symbol, decimals, balance, total-supply, token-uri, transfer) while leveraging Clarity's native fungible-token primitives.

## Project structure

- `Clarinet.toml` — Clarinet project manifest
- `contracts/bencoin.clar` — BenCoin smart contract
- `.clarinet/` — Clarinet build cache (auto-created)

## Key features

- Uses `define-fungible-token bencoin`
- SIP-010-like read-only methods:
  - `get-name`, `get-symbol`, `get-decimals`, `get-balance`, `get-total-supply`, `get-token-uri`
- Public methods:
  - `transfer(amount, sender, recipient, memo?)`
  - `mint(amount, recipient)` (only contract owner)
  - `burn(amount, sender)` (sender or owner)

## Requirements

- Clarinet CLI

## Installation (Clarinet)

Recommended options (pick one):

1) Using Cargo (fast if Rust is installed):

```bash
cargo install --locked clarinet
```

2) Using prebuilt binary (Linux x86_64):
- Download latest release from the Clarinet GitHub Releases page
- Place `clarinet` binary somewhere in your `PATH` (e.g. `~/.local/bin`)
- `chmod +x clarinet`

3) Using Docker:

```bash
docker run --rm -it -v "$PWD:/project" -w /project hirosystems/clarinet:latest clarinet check
```

## Common commands

- Type-check contracts:

```bash
clarinet check
```

- Open Clarinet console (for interactive testing):

```bash
clarinet console
```

Then, inside the console you can try:

```clarity
;; Replace with your principal
(contract-call? .bencoin mint u100000 'ST3J2GVMMM2R07ZFBJDWTYEYAR8FZH5WKDTFJ9AHA)
(contract-call? .bencoin transfer u100000 'ST3J2GVMMM2R07ZFBJDWTYEYAR8FZH5WKDTFJ9AHA 'ST2J... none)
(contract-call? .bencoin get-balance 'ST3J2GVMMM2R07ZFBJDWTYEYAR8FZH5WKDTFJ9AHA)
```

## Notes

- `mint` is restricted to the contract owner (the deployer principal).
- `burn` can be called by the token holder or the owner.
- `transfer` requires `sender` to be the transaction sender.
