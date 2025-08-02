//
//  HomePageView.swift
//  Vote-inator
//
//  Created by Oliver Holmes on 12/11/24.
//

import SwiftUI

struct HomePageView: View {
    @ObservedObject var metaMaskRepo: MetaMaskRepo
    @StateObject var vm: BlockchainService
    @State var selectedCommunity: Community?

    init(metaMaskRepo: MetaMaskRepo) {
        self.metaMaskRepo = metaMaskRepo
        _vm = StateObject(wrappedValue: BlockchainService(metaMaskRepo: metaMaskRepo))
    }

    var body: some View {
        
        VStack {
            if vm.isLoading == true {
                ProgressView()
            } else {
                Text("Welcome Back!")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top, 10)
                
                Text("You are now connected to the blockchain. Here you can vote on proposals and view the results.")
                    .font(.title3)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .opacity(0.8)
                
                List(vm.communities.indices, id: \.self) { index in
                    let community = vm.communities[index]
                    CommunityWidget(community: community, selectedCommunity: $selectedCommunity)
                }
                .listStyle(.plain)

            }
        }
        .onAppear {
            vm.fetchAllCommunities()
        }
        .sheet(item: $selectedCommunity) { community in
            ProposalWidget(proposal: community.proposals, blockchainService: vm)
                .presentationDetents([.medium, .large])
        }
        .onReceive(NotificationCenter.default.publisher(for: .refresh)) { refresh in
            print("Refreshing Home Page")
            vm.fetchAllCommunities()
        }
            
    }
}

#Preview {
    HomePageView(metaMaskRepo: MetaMaskRepo())
}


#Preview {
    HomePageView(metaMaskRepo: MetaMaskRepo())
}
