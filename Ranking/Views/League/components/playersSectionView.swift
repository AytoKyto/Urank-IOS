//
//  playersSectionView.swift
//  Ranking
//
//  Created by Mathis Fleury on 29/01/2024.
//

import SwiftUI

struct playersSectionView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Tout les joueurs")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
            }
            if let players = leagueUserViewModel.leagueUserShow?.data {
                ForEach(players, id: \.id) { player in
                    NavigationLink(destination: DetailBattelView(battel: player)) {
                        CardPlayerView(scoreElo: Double(player.elo), player1: player.user.name)
                    }
                }
            } else {
                Text("Chargement...")
            }
        }
    }
}

#Preview {
    playersSectionView()
}
