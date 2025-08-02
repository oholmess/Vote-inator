//
//  CommunityWidget.swift
//  Vote-inator
//
//  Created by Oliver Holmes on 12/11/24.
//

import SwiftUI

struct CommunityWidget: View {
    let community: Community
    @Binding var selectedCommunity: Community?
    
    var body: some View {
        VStack {
            preview
        }
        .background(Color.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
        .shadow(radius: 6, x: 5, y: 5)
//        .padding()
    }
    
    var preview: some View {
        VStack {
            Image(getRandomBanner())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(community.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
                HStack {
                    Image(systemName: "person.3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    Text("\(community.members.count) members")
                        .font(.title3)
                        .foregroundStyle(.black.opacity(0.7))
                        .padding(.leading, 4)
                    
                    Spacer()
                    
                    Button {
                        selectedCommunity = community
                    } label: {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .foregroundStyle(.black.opacity(1))
                            .background {
                                Circle().strokeBorder(Color.black.opacity(0.5), lineWidth: 1)
                                    .frame(width: 30, height: 30)
                                    .padding(.bottom, 2)
                            }
                            .padding(.trailing)
                    }
                }
                
                Spacer()
            }
            .padding(.top)
            .frame(height: 100)
            .padding(.leading)
            .background(.white)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            
        }
        .frame(maxWidth: .infinity, alignment: .bottomLeading)
        .frame(height: 250)
       
    }
    
    var noProposals: some View {
        VStack {
            Text("No proposals yet")
                .font(.title2)
                .foregroundStyle(.black.opacity(0.7))
                .padding(.top, 20)
            
            Spacer()
        }
    }
    
    func getRandomBanner() -> String {
        let banners = ["banner1", "banner2", "banner3", "banner4", "banner5", "banner6", "banner7", "banner8"]
        return banners.randomElement()!
    }
}



extension Double {
    func truncate(places: Int) -> Double {
        let factor = pow(10.0, Double(places))
        return (self * factor).rounded(.down) / factor
    }
}


#Preview {
    CommunityWidget(community: Community(name: "Community Name", proposals: [
        Proposal(id: 0, title: "Proposal Title", votesFor: 6, votesAgainst: 10, isActive: true),
        Proposal(id: 1, title: "This one is interesting", votesFor: 3, votesAgainst: 20, isActive: true),
        Proposal(id: 2, title: "Proposal Title With More Words", votesFor: 5, votesAgainst: 3, isActive: true)
    ], members: [:], hasVoted: [:]), selectedCommunity: .constant(Community(name: "", proposals: [], members: [:], hasVoted: [:])))
    
//    ProposalWidget(proposal: Proposal(id: 0, title: "Proposal Title", votesFor: 5, votesAgainst: 3, isActive: true))
}
