//
//  ContentViewModel.swift
//  Vote-inator
//
//  Created by Oliver Holmes on 12/11/24.
//

import Foundation
import Web3
import Web3PromiseKit
import Web3ContractABI
import metamask_ios_sdk

class BlockchainService: ObservableObject {
    @Published var communities: [Community] = []
    @Published var isLoading = false
    private var metaMaskRepo: MetaMaskRepo
    
    init(metaMaskRepo: MetaMaskRepo) {
        self.metaMaskRepo = metaMaskRepo
    }
    
    let web3 = Web3(rpcURL: "https://polygon-mainnet.g.alchemy.com/v2/yh8Ol9neD9Ulf_8xikpRCClzBdWNjWXQ")

    func loadContract() throws -> DynamicContract {
        let contractAddress = try EthereumAddress(hex: "0x5139b21d7aca1b1F029C90bFFe3894cE6F11a2B8", eip55: true)
        let contractJsonABI = """
        [
            {
                "inputs": [],
                "stateMutability": "nonpayable",
                "type": "constructor"
            },
            {
                "inputs": [
                    {
                        "internalType": "uint256",
                        "name": "communityId",
                        "type": "uint256"
                    },
                    {
                        "internalType": "string",
                        "name": "title",
                        "type": "string"
                    }
                ],
                "name": "addProposal",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "inputs": [
                    {
                        "internalType": "uint256",
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "name": "communities",
                "outputs": [
                    {
                        "internalType": "string",
                        "name": "name",
                        "type": "string"
                    },
                    {
                        "internalType": "uint256",
                        "name": "memberCount",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [],
                "name": "communityCount",
                "outputs": [
                    {
                        "internalType": "uint256",
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [
                    {
                        "internalType": "uint256",
                        "name": "communityId",
                        "type": "uint256"
                    }
                ],
                "name": "getCommunityName",
                "outputs": [
                    {
                        "internalType": "string",
                        "name": "",
                        "type": "string"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [
                    {
                        "internalType": "uint256",
                        "name": "communityId",
                        "type": "uint256"
                    }
                ],
                "name": "getMemberCount",
                "outputs": [
                    {
                        "internalType": "uint256",
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [
                    {
                        "internalType": "uint256",
                        "name": "communityId",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "proposalId",
                        "type": "uint256"
                    }
                ],
                "name": "getProposal",
                "outputs": [
                    {
                        "internalType": "uint256",
                        "name": "proposalid",
                        "type": "uint256"
                    },
                    {
                        "internalType": "string",
                        "name": "title",
                        "type": "string"
                    },
                    {
                        "internalType": "uint256",
                        "name": "votesFor",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "votesAgainst",
                        "type": "uint256"
                    },
                    {
                        "internalType": "bool",
                        "name": "active",
                        "type": "bool"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [
                    {
                        "internalType": "uint256",
                        "name": "communityId",
                        "type": "uint256"
                    }
                ],
                "name": "getProposalCount",
                "outputs": [
                    {
                        "internalType": "uint256",
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [
                    {
                        "internalType": "uint256",
                        "name": "communityId",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "proposalId",
                        "type": "uint256"
                    }
                ],
                "name": "getProposalVotes",
                "outputs": [
                    {
                        "internalType": "uint256",
                        "name": "votesFor",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "votesAgainst",
                        "type": "uint256"
                    }
                ],
                "stateMutability": "view",
                "type": "function"
            },
            {
                "inputs": [
                    {
                        "internalType": "uint256",
                        "name": "communityId",
                        "type": "uint256"
                    }
                ],
                "name": "joinCommunity",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "inputs": [
                    {
                        "internalType": "uint256",
                        "name": "communityId",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "proposalId",
                        "type": "uint256"
                    },
                    {
                        "internalType": "bool",
                        "name": "support",
                        "type": "bool"
                    }
                ],
                "name": "vote",
                "outputs": [],
                "stateMutability": "nonpayable",
                "type": "function"
            }
        ]
        """.data(using: .utf8)!
        
        let contract = try web3.eth.Contract(json: contractJsonABI, abiKey: nil, address: contractAddress)
        return contract
    }


    func getCommunityCount() {
        do {
            print("Getting community count")
            let contract = try loadContract()
            print("Contract loaded: \(contract.methods.keys)")
            firstly {
                contract["communityCount"]!().call()
            }.done { outputs in
                print("Outputs: \(outputs)")
                if let count = outputs[""] as? BigUInt {
                    print("Number of communities: \(count)")
                } else {
                    print("No valid count found in outputs.")
                }
            }.catch { error in
                print("Error calling communityCount: \(error)")
            }
        } catch {
            print("Error: \(error)")
        }
        print("Finished getting community count")
    }
    
    /// MARK: - MetaMask Transaction Helpers
    
    private func sendMetaMaskTransaction(to: EthereumAddress, data: EthereumData, from: String) async -> Swift.Result<String, Error> {
        let fromAddress = from.lowercased()
        let toAddress = to.hex(eip55: true).lowercased()
        
        let params: [String: String] = [
            "from": fromAddress,
            "to": toAddress,
            "data": data.hex().lowercased(),
            // Omit gas to see if it fixes the issue:
             "gas": "0x186a0"
        ]

        let ethereumRequest = EthereumRequest(method: .ethSendTransaction, params: [params])
        let result: Swift.Result<String, RequestError> = await metaMaskRepo.metamaskSDK.request(ethereumRequest)
        return result.mapError { $0 as Error }
    }

    
    // MARK: - Updated Functions
    func joinCommunity(communityId: BigUInt) async {
        do {
            let selectedAddress = metaMaskRepo.metamaskSDK.account
            guard !selectedAddress.isEmpty else {
                print("No account connected to MetaMask.")
                return
            }
            
            let contract = try loadContract()
            print("Joining community with id: \(communityId)")
            
            // Create the transaction locally to get the encoded data
            guard let transaction = contract["joinCommunity"]?(communityId).createTransaction(
                nonce: nil,
                gasPrice: nil,
                maxFeePerGas: nil,
                maxPriorityFeePerGas: nil,
                gasLimit: 100000,
                from: try EthereumAddress(hex: selectedAddress, eip55: true),
                value: 0,
                accessList: [:],
                transactionType: .legacy
            ) else {
                print("Failed to create transaction")
                return
            }
            
            let data = transaction.data
            guard let to = transaction.to else {
                print("Transaction has no 'to' address")
                return
            }
            
            let sendResult = await sendMetaMaskTransaction(to: to, data: data, from: selectedAddress)
            switch sendResult {
            case .success(let txHash):
                print("Successfully joined community. Transaction Hash: \(txHash)")
            case .failure(let error):
                print("Error sending transaction: \(error)")
            }
        } catch {
            print("Error: \(error)")
        }
    }

    func voteOnCommunity(communityId: BigUInt, proposalId: BigUInt, support: Bool) async {
        do {
            let selectedAddress = metaMaskRepo.metamaskSDK.account
            guard !selectedAddress.isEmpty else {
                print("No account connected to MetaMask.")
                return
            }
            
            let contract = try loadContract()
            print("Voting on proposal \(proposalId) in community \(communityId) with support: \(support)")
            
            // Note: The vote function in the contract takes three parameters: communityId, proposalId, support
            guard let transaction = contract["vote"]?(communityId, proposalId, support).createTransaction(
                nonce: nil,
                gasPrice: nil,
                maxFeePerGas: nil,
                maxPriorityFeePerGas: nil,
                gasLimit: 100000,
                from: try EthereumAddress(hex: selectedAddress, eip55: true),
                value: 0,
                accessList: [:],
                transactionType: .legacy
            ) else {
                print("Failed to create vote transaction")
                return
            }

            let data = transaction.data
            guard let to = transaction.to else {
                print("Transaction has no 'to' address")
                return
            }

            let sendResult = await sendMetaMaskTransaction(to: to, data: data, from: selectedAddress)
            switch sendResult {
            case .success(let txHash):
                print("Voted successfully. Transaction Hash: \(txHash)")
                await MainActor.run { NotificationCenter.default.post(name: .refresh, object: nil) }
            case .failure(let error):
                print("Error sending vote transaction: \(error)")
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    
    func fetchAllCommunities() {
        isLoading = true
        do {
            let contract = try loadContract()
            firstly {
                contract["communityCount"]!().call()
            }.then { outputs -> Promise<Void> in
                guard let count = outputs[""] as? BigUInt else {
                    throw NSError(domain: "CommunityCountError", code: -1, userInfo: nil)
                }
                let totalCommunities = Int(count)
                print("Total communities: \(totalCommunities)")
                
                // Fetch each community in parallel
                let fetchPromises = (0..<totalCommunities).map { i in
                    self.fetchCommunity(communityId: BigUInt(i), contract: contract)
                }
                
                print("Fetching communities...")
                
                self.isLoading = false
                return when(fulfilled: fetchPromises).asVoid()
            }.done {
                print("All communities fetched successfully")
                self.isLoading = false
            }.catch { error in
                print("Error fetching communities: \(error)")
                self.isLoading = false
            }
        } catch {
            print("Error: \(error)")
            self.isLoading = false
        }
    }
    
    private func fetchCommunity(communityId: BigUInt, contract: DynamicContract) -> Promise<Void> {
        return firstly {
            contract["getCommunityName"]!(communityId).call()
        }.then { outputs -> Promise<(String, BigUInt)> in
            guard let name = outputs[""] as? String else {
                throw NSError(domain: "CommunityNameError", code: -1, userInfo: nil)
            }
            print("Fetching community: \(name)")
            return contract["getProposalCount"]!(communityId).call().map { proposalCountOutputs in
                guard let proposalCount = proposalCountOutputs[""] as? BigUInt else {
                    throw NSError(domain: "ProposalCountError", code: -1, userInfo: nil)
                }
                print("Fetched community: \(name)")
                return (name, proposalCount)
            }
            
        }.then { (name, proposalCount) -> Promise<(String, [Proposal])> in
            let count = Int(proposalCount)
            let proposalPromises = (0..<count).map { p in
                self.fetchProposal(communityId: communityId, proposalId: BigUInt(p), contract: contract)
            }
            
            return when(fulfilled: proposalPromises).map { proposals in
                return (name, proposals)
            }
        }.done { (name, proposals) in
            let community = Community(
                name: name,
                proposals: proposals,
                members: [:],
                hasVoted: [:]
            )
            
            DispatchQueue.main.async {
                self.communities.append(community)
            }
        }
    }
    
    private func fetchProposal(communityId: BigUInt, proposalId: BigUInt, contract: DynamicContract) -> Promise<Proposal> {
        return contract["getProposal"]!(communityId, proposalId).call().map { outputs in
            guard let proposalid = outputs["proposalid"] as? BigUInt,
                  let title = outputs["title"] as? String,
                  let votesFor = outputs["votesFor"] as? BigUInt,
                  let votesAgainst = outputs["votesAgainst"] as? BigUInt,
                  let active = outputs["active"] as? Bool else {
                throw NSError(domain: "ProposalDataError", code: -1, userInfo: nil)
            }
            
            return Proposal(
                id: UInt(proposalid),
                title: title,
                votesFor: UInt(votesFor),
                votesAgainst: UInt(votesAgainst),
                isActive: active
            )
        }
    }
}


extension Data {
    static func fromHex(_ hex: String) -> Data? {
        var data = Data()
        var hex = hex
        // Remove 0x prefix if present
        if hex.hasPrefix("0x") {
            hex = String(hex.dropFirst(2))
        }
        var tempHex = ""
        for char in hex {
            tempHex.append(char)
            if tempHex.count == 2 {
                if let byte = UInt8(tempHex, radix: 16) {
                    data.append(byte)
                    tempHex = ""
                } else {
                    return nil
                }
            }
        }
        return data
    }
}
