//
//  WinnersSelectionView.swift
//  Ranking
//
//  Created by Mathis Fleury on 06/01/2024.
//

import SwiftUI

struct UsersSelectionView: View {
    @Binding var selectedUsers: Set<UserInLeagueIdElo>
    var usersData: [LeagueUser]
    
    var body: some View {
            List(usersData) { player in
                HStack {
                    Text(player.user.name)
                    Spacer()
                    Button(action: {
                        let user = UserInLeagueIdElo(id: player.user.id, elo: player.elo , name:player.user.name)
                          if selectedUsers.contains(user) {
                              selectedUsers.remove(user)
                          } else {
                              selectedUsers.insert(user)
                          }
                    }) {
                        Image(systemName: selectedUsers.contains(UserInLeagueIdElo(id:  player.user.id, elo: player.elo , name:player.user.name)) ? "checkmark.circle.fill" : "circle")
                    }
                }
            }
        }
}
