//
//  ProposalWidget.swift
//  Vote-inator
//
//  Created by Oliver Holmes on 12/11/24.
//

import Foundation
import SwiftUI
import Web3

struct ProposalWidget: View {
    let proposal: [Proposal]
    @ObservedObject var blockchainService: BlockchainService
    
    init(proposal: [Proposal], blockchainService: BlockchainService) {
        self.proposal = proposal
        self.blockchainService = blockchainService    }
    
    var body: some View {
        ScrollView {
            ForEach(proposal) { proposal in
                ProposalView(proposal: proposal, blockchainService: blockchainService)
            }
        }
        .padding(.top)
    }
    
//    func content(proposal: Proposal) -> some View {
//        VStack {
//            HStack {
//                Text(proposal.title)
//                    .font(.title2)
//                    .fontWeight(.semibold)
//                    .foregroundStyle(.black)
//                    .multilineTextAlignment(.leading)
//                
//                Spacer()
//                
//                Text(proposal.isActive ? "active" : "closed")
//                    .font(.title3)
//                    .foregroundStyle(proposal.isActive ? .green : .red)
//                    .padding(.horizontal, 12)
//                    .padding(.vertical, 4)
//                    .background {
//                        RoundedRectangle(cornerRadius: 30)
//                            .fill(proposal.isActive ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
//                    }
//            }
//            .padding()
//            
//            // Progress bar that shows the ratio of votes for and against
//            ProgressView(value: Double(proposal.votesFor), total: Double(proposal.votesFor + proposal.votesAgainst)) {
//                HStack {
//                    // Calculate the percentage of votes for
//                    let percentage = proposal.votesFor == 0 ? 0 : Double(proposal.votesFor) / Double(proposal.votesFor + proposal.votesAgainst)
//                    Text(String(format: "%.2f%% For", percentage * 100)) // Formats to 2 decimal places without extra zeros
//                        .font(.caption)
//                        .foregroundStyle(.black.opacity(0.7))
//                    
//                    Spacer()
//                    
//                    // Calculate the percentage of votes against
//                    let percentageAgainst = proposal.votesAgainst == 0 ? 0 : Double(proposal.votesAgainst) / Double(proposal.votesFor + proposal.votesAgainst)
//                    Text(String(format: "%.2f%% Against", percentageAgainst * 100)) // Formats to 2 decimal places without extra zeros
//                        .font(.caption)
//                        .foregroundStyle(.black.opacity(0.7))
//                }
//            }
//            .progressViewStyle(BarProgressStyle(height: 8))
//            .frame(height: 30)
//            .padding(.horizontal)
//            
//            HStack {
//                let endDate = Date().addingTimeInterval(Foundation.TimeInterval.random(in: 0...1000000))
//                Text("Ends in \(endDate, style: .relative) on \(endDate, style: .date)")
//                    .font(.caption)
//                    .foregroundStyle(.black.opacity(0.7))
//                    .padding(.top, 4)
//                
//                Spacer()
//                
//                Button {
//                    blockchainService.joinCommunity(communityId: 1)
//                    blockchainService.voteOnCommunity(communityId: 1, proposalId: proposal.id, support: true)
//                } label: {
//                    HStack {
//                        Image(systemName: "checkmark")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 12, height: 12)
//                            .foregroundStyle(.white)
//                        
//                        Text("For")
//                            .font(.system(size: 15))
//                            .foregroundStyle(.white)
//                    }
//                    .padding(.horizontal)
//                    .padding(.vertical, 6)
//                    .background {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.green)
//                    }
//                }
//                
//                
//                Button {
//                    blockchainService.joinCommunity(communityId: 1)
//                    blockchainService.voteOnCommunity(communityId: 1, proposalId: proposal.id, support: false)
//                } label: {
//                    HStack {
//                        Image(systemName: "xmark")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 12, height: 12)
//                            .foregroundStyle(.white)
//                        
//                        Text("Against")
//                            .font(.system(size: 15))
//                            .foregroundStyle(.white)
//                    }
//                    .padding(.horizontal)
//                    .padding(.vertical, 6)
//                    .background {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.red)
//                    }
//                }
//            }
//            .padding()
//            
//        }
//        .background {
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color.white)
//                .shadow(radius: 5, x: 2, y: 6).opacity(0.8)
//        }
//        .padding(.horizontal)
//    }
    
    struct ProposalView: View {
        @State var votesFor: UInt
        @State var votesAgainst: UInt
        @ObservedObject var blockchainService: BlockchainService
        let proposal: Proposal
        let title: String
        let isActive: Bool
        let endDate = Date().addingTimeInterval(TimeInterval.random(in: 0...1_000_000))
        
        init(proposal: Proposal, blockchainService: BlockchainService) {
            self.title = proposal.title
            self.isActive = proposal.isActive
            self.proposal = proposal
            self._votesFor = State(initialValue: proposal.votesFor)
            self._votesAgainst = State(initialValue: proposal.votesAgainst)
            self.blockchainService = blockchainService
        }
        
        var totalVotes: Double {
            Double(votesFor + votesAgainst)
        }
        
        var percentageFor: Double {
            totalVotes == 0 ? 0 : Double(votesFor) / totalVotes
        }
        
        var percentageAgainst: Double {
            totalVotes == 0 ? 0 : Double(votesAgainst) / totalVotes
        }
        
        var body: some View {
            VStack {
                HStack {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text(isActive ? "active" : "closed")
                        .font(.title3)
                        .foregroundStyle(isActive ? .green : .red)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(isActive ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                        )
                }
                .padding()
                
                ProgressView(value: Double(votesFor), total: totalVotes) {
                    HStack {
                        Text(String(format: "%.2f%% For", percentageFor * 100))
                            .font(.caption)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        Spacer()
                        
                        Text(String(format: "%.2f%% Against", percentageAgainst * 100))
                            .font(.caption)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                }
                .progressViewStyle(BarProgressStyle(height: 8))
                .frame(height: 30)
                .padding(.horizontal)
                
                HStack {
                    Text("Ends in \(endDate, style: .relative) on \(endDate, style: .date)")
                        .font(.caption)
                        .foregroundStyle(.black.opacity(0.7))
                        .padding(.top, 4)
                    
                    Spacer()
                    
                    Button {
                        Task { await blockchainService.voteOnCommunity(communityId: 1, proposalId: BigUInt(proposal.id), support: true) }
                        votesFor += 1
                        print("votesFor: \(votesFor)")
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.white)
                            Text("For")
                                .font(.system(size: 15))
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.green)
                        }
                    }
                    
                    Button {
                        Task { await blockchainService.voteOnCommunity(communityId: 1, proposalId: BigUInt(proposal.id), support: false) }
                        votesAgainst += 1
                        print("votesAgainst: \(votesAgainst)")
                    } label: {
                        HStack {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.white)
                            Text("Against")
                                .font(.system(size: 15))
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.red)
                        }
                    }
                }
                .padding()
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 5, x: 2, y: 6).opacity(0.8)
            }
            .padding(.horizontal)
        }
    }

    
//    func content(proposal: Proposal) -> some View {
//        // Compute values before building the view
//        @State var totalVotes = Double(proposal.votesFor + proposal.votesAgainst)
//        
//        @State var votesFor = proposal.votesFor
//        @State var votesAgainst = proposal.votesAgainst
//        var percentageFor = totalVotes == 0 ? 0.0 : Double(votesFor) / totalVotes
//        var percentageAgainst = totalVotes == 0 ? 0.0 : Double(votesAgainst) / totalVotes
//        let endDate = Date().addingTimeInterval(TimeInterval.random(in: 0...1_000_000))
//        
//        return VStack {
//            HStack {
//                Text(proposal.title)
//                    .font(.title2)
//                    .fontWeight(.semibold)
//                    .foregroundStyle(.black)
//                    .multilineTextAlignment(.leading)
//                
//                Spacer()
//                
//                Text(proposal.isActive ? "active" : "closed")
//                    .font(.title3)
//                    .foregroundStyle(proposal.isActive ? .green : .red)
//                    .padding(.horizontal, 12)
//                    .padding(.vertical, 4)
//                    .background {
//                        RoundedRectangle(cornerRadius: 30)
//                            .fill(proposal.isActive ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
//                    }
//            }
//            .padding()
//            
//            ProgressView(value: Double(votesFor), total: totalVotes) {
//                HStack {
//                    Text(String(format: "%.2f%% For", percentageFor * 100))
//                        .font(.caption)
//                        .foregroundStyle(.black.opacity(0.7))
//                    
//                    Spacer()
//                    
//                    Text(String(format: "%.2f%% Against", percentageAgainst * 100))
//                        .font(.caption)
//                        .foregroundStyle(.black.opacity(0.7))
//                }
//            }
//            .progressViewStyle(BarProgressStyle(height: 8))
//            .frame(height: 30)
//            .padding(.horizontal)
//            
//            HStack {
//                Text("Ends in \(endDate, style: .relative) on \(endDate, style: .date)")
//                    .font(.caption)
//                    .foregroundStyle(.black.opacity(0.7))
//                    .padding(.top, 4)
//                
//                Spacer()
//                
//                Button {
//                    Task {
////                        await blockchainService.joinCommunity(communityId: 1)
////                        await blockchainService.voteOnCommunity(communityId: 1, proposalId: BigUInt(proposal.id), support: true)
//                        votesFor += 1
//                        print("votesFor: \(votesFor)")
//                    }
//                } label: {
//                    HStack {
//                        Image(systemName: "checkmark")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 12, height: 12)
//                            .foregroundStyle(.white)
//                        
//                        Text("For")
//                            .font(.system(size: 15))
//                            .foregroundStyle(.white)
//                    }
//                    .padding(.horizontal)
//                    .padding(.vertical, 6)
//                    .background {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.green)
//                    }
//                }
//                
//                Button {
//                    Task {
////                        await blockchainService.joinCommunity(communityId: 1)
////                        await blockchainService.voteOnCommunity(communityId: 1, proposalId: BigUInt(proposal.id), support: false)
//                        votesAgainst += 1
//                        print("votesAgainst: \(votesAgainst)")
//                    }
//                } label: {
//                    HStack {
//                        Image(systemName: "xmark")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 12, height: 12)
//                            .foregroundStyle(.white)
//                        
//                        Text("Against")
//                            .font(.system(size: 15))
//                            .foregroundStyle(.white)
//                    }
//                    .padding(.horizontal)
//                    .padding(.vertical, 6)
//                    .background {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.red)
//                    }
//                }
//            }
//            .padding()
//            
//        }
//        .background {
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color.white)
//                .shadow(radius: 5, x: 2, y: 6).opacity(0.8)
//        }
//        .padding(.horizontal)
//    }

    
}

struct BarProgressStyle: ProgressViewStyle {
    var color: Color = .blue
    var height: Double = 20.0
    var labelFontStyle: Font = .body

    func makeBody(configuration: Configuration) -> some View {

        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { geometry in

            VStack(alignment: .leading) {

                configuration.label
                    .font(labelFontStyle)

                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color(uiColor: .systemGray5))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {

                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                    }

            }

        }
    }
}
