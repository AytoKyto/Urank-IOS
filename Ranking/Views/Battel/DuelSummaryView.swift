//
//  DuelSummaryView.swift
//  Ranking
//
//  Created by Mathis Fleury on 06/01/2024.
//

import SwiftUI

struct DuelSummaryView: View {
    let selectedLeague: String
    let selectedWinners: Set<Int>
    let selectedLosers: Set<Int>
    let duelDescription: String

    var body: some View {
        VStack {
            Text("Duel Summary")
            Text("Selected League: \(selectedLeague)")
            Text("Selected Winners: \(selectedWinners.map { "Player \($0 + 1)" }.joined(separator: ", "))")
            Text("Selected Losers: \(selectedLosers.map { "Player \($0 + 1)" }.joined(separator: ", "))")
            Text("Duel Description: \(duelDescription)")
        }
        .padding()
    }
}

struct DuelSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        DuelSummaryView(selectedLeague: "League A", selectedWinners: [0, 1], selectedLosers: [2], duelDescription: "Test Duel")
    }
}
