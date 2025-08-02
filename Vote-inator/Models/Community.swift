//
//  Community.swift
//  Vote-inator
//
//  Created by Oliver Holmes on 12/11/24.
//

struct Community: Identifiable {
    let id: String?
    let name: String
    var proposals: [Proposal]
    var members: [String: Bool] // Mapping of member addresses to their status
    var hasVoted: [String: [UInt: Bool]] // Nested mapping for address -> proposalId -> voted status
    
    init(id: String? = nil, name: String, proposals: [Proposal], members: [String: Bool] = [:], hasVoted: [String: [UInt: Bool]] = [:]) {
        self.id = id
        self.name = name
        self.proposals = proposals
        self.members = members
        self.hasVoted = hasVoted
    }
}
