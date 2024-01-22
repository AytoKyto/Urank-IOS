//
//  WinnersSelectionView.swift
//  Ranking
//
//  Created by Mathis Fleury on 06/01/2024.
//

import SwiftUI

struct WinnersSelectionView: View {
    @Binding var selectedWinners: Set<Int>
    var usersData: [LeagueUser]
    
    var body: some View {
        VStack {
            Text("Select Winners")
                .font(.title3)

            List(usersData ?? []) { player in
                HStack {
                    Text(player.user.name)
                    Spacer()
                    Button(action: {
                        if selectedWinners.contains(player.id) {
                            selectedWinners.remove(player.id)
                        } else {
                            selectedWinners.insert(player.id)
                        }
                    }) {
                        Image(systemName: selectedWinners.contains(player.id) ? "checkmark.circle.fill" : "circle")
                    }
                }
            }
        }
    }
}
