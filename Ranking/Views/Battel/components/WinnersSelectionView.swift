//
//  WinnersSelectionView.swift
//  Ranking
//
//  Created by Mathis Fleury on 06/01/2024.
//

import SwiftUI

struct WinnersSelectionView: View {
    @Binding var selectedWinners: Set<Int>
    let players = ["Player 1", "Player 2", "Player 3"]

    var body: some View {
        VStack {
            Text("Select Winners")
                .font(.title3)

            List(players, id: \.self) { player in
                HStack {
                    Text(player)
                    Spacer()
                    Button(action: {
                        if selectedWinners.contains(players.firstIndex(of: player)!) {
                            selectedWinners.remove(players.firstIndex(of: player)!)
                        } else {
                            selectedWinners.insert(players.firstIndex(of: player)!)
                        }
                    }) {
                        if selectedWinners.contains(players.firstIndex(of: player)!) {
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

struct WinnersSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        WinnersSelectionView(selectedWinners: .constant([]))
    }
}
