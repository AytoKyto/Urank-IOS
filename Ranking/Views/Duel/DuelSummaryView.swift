//
//  DuelSummaryView.swift
//  Ranking
//
//  Created by Mathis Fleury on 06/01/2024.
//

import SwiftUI

struct DuelSummaryView: View {
    let selectedLeague: String
    let selectedWinners: Set<UserInLeagueIdElo>
    let selectedLosers: Set<UserInLeagueIdElo>
    let duelDescription: String

    var body: some View {
        VStack {
            Text("Duel Summary")
            Text("Selected League: \(selectedLeague)")

            // Displaying the IDs (or other properties) of selected winners
            Text("Selected Winners: \(selectedWinners.map { "\($0.name)" }.joined(separator: ", "))")

            // Displaying the IDs (or other properties) of selected losers
            Text("Selected Losers: \(selectedLosers.map { "\($0.name)" }.joined(separator: ", "))")

            Text("Duel Description: \(duelDescription)")
        }
        .padding()
    }
}
