# StaxStake - Liquid Staking Protocol

## Overview
StaxStake is a liquid staking protocol built on the Stacks blockchain that allows users to stake their STX tokens and receive stSTX tokens in return. These stSTX tokens represent the user's staked position and can be used in other DeFi applications while the original STX continues to earn staking rewards.

## Features
- Stake STX and receive stSTX tokens
- Unstake at any time by returning stSTX tokens
- Earn staking rewards automatically
- Use stSTX in other DeFi protocols while earning staking rewards

## Contract Functions

### Public Functions
- `stake(amount)`: Stake STX and receive stSTX tokens
- `unstake(amount)`: Return stSTX tokens and receive STX back
- `update-reward-rate(new-rate)`: Admin function to update the reward rate

### Read-Only Functions
- `get-total-staked()`: Get the total amount of STX staked in the protocol
- `get-reward-rate()`: Get the current reward rate in basis points
- `get-staking-stats()`: Get combined statistics about the staking protocol

## Development
This project uses Clarinet for testing and deployment.

### Prerequisites
- Clarinet
- Stacks CLI

### Testing
Run tests with:
\`\`\`bash
clarinet test
\`\`\`

### Deployment
Deploy to testnet or mainnet using Clarinet:
\`\`\`bash
clarinet deploy --testnet