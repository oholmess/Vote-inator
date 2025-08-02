//
//  Proposal.swift
//  Vote-inator
//
//  Created by Oliver Holmes on 12/11/24.
//

import Foundation

struct Proposal: Identifiable {
    let id: UInt // equivalent to `proposalid`
    let title: String
    let votesFor: UInt
    let votesAgainst: UInt
    let isActive: Bool
}
