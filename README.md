# BTC Lending Protocol

A decentralized lending platform built on the Stacks blockchain that enables users to deposit Bitcoin as collateral and borrow against it. The protocol implements automated liquidations, dynamic interest rates, and protocol-level security measures.

## Features

- **Collateralized Lending**: Users can deposit BTC as collateral and borrow against it
- **Automated Liquidations**: Protection against undercollateralized positions
- **Price Oracle Integration**: Real-time BTC price feeds with validity checks
- **Flexible Interest Rates**: 5% APR base rate
- **Governance Controls**: Protocol fee management and emergency pause functionality

## Key Parameters

- Minimum Collateral Ratio: 150%
- Liquidation Threshold: 130%
- Liquidation Penalty: 10%
- Price Validity Period: 1 hour
- Base Protocol Fee: 1%

## Core Functions

### User Operations

- `deposit-collateral`: Deposit BTC as collateral
- `borrow`: Take out a loan against deposited collateral
- `repay-loan`: Repay an existing loan with interest
- `liquidate`: Liquidate undercollateralized positions

### Read-Only Functions

- `get-loan`: Retrieve loan details for a specific user
- `get-collateral-balance`: Check collateral balance
- `get-borrow-balance`: Check borrowed amount
- `get-current-collateral-ratio`: Calculate current collateral ratio

### Administrative Functions

- `update-btc-price`: Update the BTC price oracle
- `update-protocol-fee`: Modify protocol fee (max 10%)
- `pause-protocol`: Emergency protocol pause

## Error Codes

| Code | Description              |
| ---- | ------------------------ |
| 100  | Not Authorized           |
| 101  | Insufficient Balance     |
| 102  | Invalid Amount           |
| 103  | Below Minimum Collateral |
| 104  | Loan Not Found           |
| 105  | Loan Already Exists      |
| 106  | Invalid Liquidation      |
| 107  | Price Expired            |

## Security Features

- Price oracle validity checks
- Minimum collateral requirements
- Automated liquidation triggers
- Contract owner authorization checks
- Maximum fee caps

## Protocol Math

The protocol uses the following key calculations:

- **Collateral Ratio** = (Collateral Value × 100) ÷ Borrowed Value
- **Interest Amount** = (Borrowed Amount × Interest Rate × Blocks Elapsed) ÷ (100 × 144 × 365)
- **Liquidation Value** = Borrowed Amount × (100 + Liquidation Penalty)

## Getting Started

To interact with the protocol:

1. Ensure you have sufficient BTC for collateral
2. Call `deposit-collateral` to secure your position
3. Use `borrow` to take out a loan (maintaining >150% collateral ratio)
4. Monitor your position's health using `get-current-collateral-ratio`
5. Repay loans before reaching the liquidation threshold (130%)

## Risk Considerations

- Maintain adequate collateral ratio to avoid liquidation
- Monitor BTC price movements
- Be aware of interest accrual on borrowed amounts
- Understand liquidation penalties and triggers

## Governance

The protocol includes governance mechanisms for:

- Fee adjustment (capped at 10%)
- Emergency protocol pausing
- Price oracle updates

## Technical Requirements

- Stacks blockchain compatibility
- Access to accurate BTC price feeds
- Sufficient STX for transaction fees

## Contributing

This protocol is open for review and improvement suggestions. Please ensure all proposed changes maintain or enhance the security and stability of the system.
