//
//  WinnersSelectionView.swift
//  Ranking
//
//  Created by Mathis Fleury on 06/01/2024.
//

import SwiftUI

struct WinnersSelectionView: View {
    @Binding var selectedWinners: Set<UserInLeagueIdElo>
    var usersData: [LeagueUser]
    
    var body: some View {
        VStack {
            Text("Select Winners")
                .font(.title3)

            List(usersData) { player in
                HStack {
                    Text(player.user.name)
                    Spacer()
                    Button(action: {
                        let user = UserInLeagueIdElo(id: player.id, elo: player.elo, name:player.user.name)
                          if selectedWinners.contains(user) {
                              selectedWinners.remove(user)
                          } else {
                              selectedWinners.insert(user)
                          }
                    }) {
                        Image(systemName: selectedWinners.contains(UserInLeagueIdElo(id: player.id, elo: player.elo, name:player.user.name)) ? "checkmark.circle.fill" : "circle")
                    }
                }
            }
        }
    }
}
