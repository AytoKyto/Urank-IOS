//
//  LosersSelectionView.swift
//  Ranking
//
//  Created by Mathis Fleury on 06/01/2024.
//

import SwiftUI

struct LosersSelectionView: View {
    @Binding var selectedLosers: Set<UserInLeagueIdElo>
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
                        let user = UserInLeagueIdElo(id: player.id, elo: player.elo, name:player.user.name)
                        if selectedLosers.contains(user) {
                            selectedLosers.remove(user)
                        } else {
                            selectedLosers.insert(user)
                        }
                    }) {
                        Image(systemName: selectedLosers.contains(UserInLeagueIdElo(id: player.id, elo: player.elo, name:player.user.name)) ? "checkmark.circle.fill" : "circle")

                    }
                }
            }
        }
    }
}
