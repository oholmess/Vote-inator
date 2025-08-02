# Vote-inator 3000 🗳️

## Introduction ℹ️

This is a personal project created 100% alone. I wanted to challenge myself to make a basic functioning blockchain powered voting application under 6 hours from scratch, every line coded by me. That estimation turned out to be quite... optimistic. I managed to get the application functioning after around 14 hours of work. Which I'm still proud of.


## Project Overview 📄

---

# Vote-inator 🗳️

A decentralized voting iOS application that enables community-based governance through blockchain technology. Vote-inator connects to MetaMask wallets and allows users to participate in transparent, immutable voting processes across various communities.

## Features ✨

- **🔐 MetaMask Integration**: Secure wallet connection for blockchain authentication
- **🏛️ Community Governance**: Browse and join different voting communities
- **📊 Proposal Voting**: Vote "for" or "against" community proposals
- **📈 Real-time Results**: Live vote tracking with visual progress indicators
- **⛓️ Blockchain Transparency**: All votes recorded immutably on Polygon network
- **🎨 Modern UI**: Clean SwiftUI interface with beautiful gradient banners

## Screenshots 📱

The app features a modern interface with:
- Ethereum-themed login screen with MetaMask integration
- Community cards with random gradient banners
- Detailed proposal views with vote percentages  
- Progress bars showing voting results

## Technology Stack 🛠️

- **Frontend**: SwiftUI (iOS)
- **Blockchain**: Ethereum/Polygon Network
- **Wallet**: MetaMask iOS SDK
- **Web3**: Web3.swift, Web3PromiseKit, Web3ContractABI
- **Smart Contracts**: Solidity-based voting contracts

## Architecture 🏗️

```
Vote-inator/
├── Models/
│   ├── Community.swift      # Community data structure
│   └── Proposal.swift       # Proposal data structure
├── Authorization/
│   ├── LoginView.swift      # MetaMask login interface
│   └── MetaMaskRepo.swift   # Wallet connection logic
├── Home Page/
│   ├── HomePageView.swift   # Main community browser
│   └── BlockchainService.swift # Smart contract interactions
├── Widgets/
│   ├── CommunityWidget.swift # Community card UI
│   └── ProposalWidget.swift  # Voting interface
└── Assets.xcassets/         # UI assets and banners
```

## Smart Contract Integration 📜

The app interacts with a custom voting smart contract deployed on Polygon that supports:

- **Community Management**: Create and manage voting communities
- **Proposal System**: Add proposals to communities
- **Voting Logic**: Cast votes with support/opposition
- **Member Tracking**: Track community membership
- **Vote Counting**: Transparent vote tallying

### Key Contract Methods:
- `joinCommunity(uint256 communityId)`
- `vote(uint256 communityId, uint256 proposalId, bool support)`
- `addProposal(uint256 communityId, string title)`
- `getProposal(uint256 communityId, uint256 proposalId)`

## Getting Started 🚀

### Prerequisites

- iOS 15.0+
- Xcode 14.0+
- MetaMask mobile app installed
- Polygon network configured in MetaMask

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/Vote-inator.git
cd Vote-inator
```

2. Open the project in Xcode:
```bash
open Vote-inator.xcodeproj
```

3. Install dependencies via Swift Package Manager (already configured in project)

4. Build and run the project on your device or simulator

### Configuration

The app is configured to connect to:
- **Network**: Polygon Mainnet
- **RPC URL**: Alchemy endpoint
- **Contract Address**: `0x5139b21d7aca1b1F029C90bFFe3894cE6F11a2B8`

## Usage 📖

### 1. Connect Wallet
- Launch the app
- Tap "Connect to MetaMask" 
- Approve the connection in MetaMask app
- Switch to Polygon network if prompted

### 2. Browse Communities  
- View available voting communities on the home screen
- Each community shows member count and available proposals
- Tap the dropdown arrow to view community proposals

### 3. Vote on Proposals
- Select a community to view its proposals
- Review proposal details and current vote percentages
- Tap "For" or "Against" to cast your vote
- Confirm the transaction in MetaMask
- View updated results in real-time

### 4. Join Communities
- Communities automatically handle membership when you vote
- Join communities to participate in governance decisions

## Data Models 📊

### Community
```swift
struct Community {
    let id: String?
    let name: String
    var proposals: [Proposal]
    var members: [String: Bool]
    var hasVoted: [String: [UInt: Bool]]
}
```

### Proposal  
```swift
struct Proposal {
    let id: UInt
    let title: String
    let votesFor: UInt
    let votesAgainst: UInt
    let isActive: Bool
}
```

## Contributing 🤝

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Security Considerations 🔒

- All transactions require MetaMask approval
- Private keys never leave the MetaMask app
- Smart contract interactions are read-only except for explicit voting actions
- Vote data is immutably stored on blockchain

## Roadmap 🗺️

- [ ] Multi-network support (Ethereum mainnet, other L2s)
- [ ] Proposal creation interface  
- [ ] Community creation functionality
- [ ] Push notifications for new proposals
- [ ] Vote delegation features
- [ ] Enhanced analytics and voting history

## Dependencies 📦

- `metamask_ios_sdk`: MetaMask wallet integration
- `Web3.swift`: Ethereum blockchain interaction
- `Web3PromiseKit`: Promise-based async Web3 calls  
- `Web3ContractABI`: Smart contract ABI handling

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments 🙏

- MetaMask team for the excellent iOS SDK
- Web3.swift contributors for blockchain tooling
- Unsplash for the beautiful gradient banner images
- The Ethereum and Polygon communities

## Support 💬

For questions or support, please:
- Open an issue on GitHub
- Check existing documentation
- Review smart contract interactions in `BlockchainService.swift`

---

**Vote-inator 3000** - Democratizing decision-making through decentralized technology! 🗳️⚡