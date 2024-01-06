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
                .font(.title)

            Text("League: \(selectedLeague)")
            Text("Winners: \(selectedWinners.map { "Player \($0 + 1)" }.joined(separator: ", "))")
            Text("Losers: \(selectedLosers.map { "Player \($0 + 1)" }.joined(separator: ", "))")
            Text("Description: \(duelDescription)")

            Spacer()

            HStack {
                NavigationLink(destination: MainNavView()) {
                    Text("Cancel")
                        .padding()
                }

                Button("Add Duel") {
                    // Ajouter le duel
                }
                .padding()
            }
        }
    }
}
