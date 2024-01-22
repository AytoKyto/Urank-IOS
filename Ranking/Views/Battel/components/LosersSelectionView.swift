//
//  LosersSelectionView.swift
//  Ranking
//
//  Created by Mathis Fleury on 06/01/2024.
//

import SwiftUI

struct LosersSelectionView: View {
    @Binding var selectedLosers: Set<Int>
    @State var usersData: [LeagueUser]?

    var body: some View {
        VStack {
            Text("Select Losers")
                .font(.title3)

            List(usersData ?? []) { player in
                HStack {
                    Text(player.user.name)
                    Spacer()
                    Button(action: {
                        if selectedLosers.contains(player.id) {
                            selectedLosers.remove(player.id)
                        } else {
                            selectedLosers.insert(player.id)
                        }
                    }) {
                        Image(systemName: selectedLosers.contains(player.id) ? "checkmark.circle.fill" : "circle")
                    }
                }
            }
        }
    }
}
