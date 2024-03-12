//
//  CardPlayerView.swift
//  Ranking
//
//  Created by Mathis Fleury on 11/11/2023.
//

import SwiftUI
import UIKit

struct CardPlayerView: View {
    @StateObject private var leagueUserViewModel = LeagueUserViewModel()
    
    let scoreElo: Double
    let player1: String
    let leagueId: Int
    let userId: Int
    let updateData: () -> Void

    init(scoreElo: Double, player1: String, leagueId: Int, userId: Int, updateData: @escaping () -> Void) {
        self.scoreElo = scoreElo
        self.player1 = player1
        self.leagueId = leagueId
        self.userId = userId
        self.updateData = updateData
    }

    var body: some View {
        HStack {
            HStack(alignment: .center) {
                HStack {
                    let firstLetterP1 = String(player1.prefix(1)).uppercased()
                    let lastLetterP1 = String(player1.suffix(1)).uppercased()

                    Text(firstLetterP1 + lastLetterP1)
                        .foregroundColor(Color.black)
                        .frame(width: 45.0, height: 45.0)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(999.0)
                }
                VStack(alignment: .leading) {
                    Text("Joueur")
                        .font(.footnote)
                        .foregroundColor(Color("PrimaryTextColor"))
                    Text(player1)
                        .font(.title3)
                }
                Spacer()
                Text(String(format: "%.0f", scoreElo))
                    .font(.title2)
            }
            .padding(.all, 20.0)
            .background(Color(.systemBackground))
            .cornerRadius(10.0)
            Button(action: {
                leagueUserViewModel.deleteUsersInLeague(userId: userId, leagueId: leagueId)
                updateData()
            }) {
                HStack {
                    Image(systemName: "trash")
                }
                .padding()
                .background(Color.red)
                .cornerRadius(8)
            }
        }
      
    }
}
