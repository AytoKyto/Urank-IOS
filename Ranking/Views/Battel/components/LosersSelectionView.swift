//
//  LosersSelectionView.swift
//  Ranking
//
//  Created by Mathis Fleury on 06/01/2024.
//

import SwiftUI

struct LosersSelectionView: View {
    @Binding var selectedLosers: Set<Int>
    let players = ["Player 1", "Player 2", "Player 3"]

    var body: some View {
        VStack {
            Text("Select Losers")
                .font(.title3)

            List(players, id: \.self) { player in
                HStack {
                    Text(player)
                    Spacer()
                    Button(action: {
                        if selectedLosers.contains(players.firstIndex(of: player)!) {
                            selectedLosers.remove(players.firstIndex(of: player)!)
                        } else {
                            selectedLosers.insert(players.firstIndex(of: player)!)
                        }
                    }) {
                        if selectedLosers.contains(players.firstIndex(of: player)!) {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "circle")
                        }
                    }
                }
            }
        }
    }
}
