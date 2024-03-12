//
//  duelsSectionView.swift
//  Ranking
//
//  Created by Mathis Fleury on 29/01/2024.
//

import SwiftUI

struct duelsSectionView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Tout les duels")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
            }
            // Add a ForEach loop for duels similar to players if needed
            CardBattelView(leagueTitle: "Ping pong", scoreElo: 100, player1: "Mathis", player2: "Jeremy")
        }
    }
}
