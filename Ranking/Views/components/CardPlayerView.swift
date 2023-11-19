//
//  CardPlayerView.swift
//  Ranking
//
//  Created by Mathis Fleury on 11/11/2023.
//

import SwiftUI

struct CardPlayerView: View {
    let scoreElo: Double
    let player1: String
    
    init(scoreElo: Double, player1: String) {
        self.scoreElo = scoreElo
        self.player1 = player1
    }
        
    var body: some View {
        HStack(alignment: .center) {
            HStack() {
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
            Text((String(format: "%.0f", scoreElo)))
                .font(.title2)
        }
        .padding(.all, 20.0)
        .background(Color(.systemBackground))
        .cornerRadius(10.0)
    }
}

struct CardPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        CardPlayerView(scoreElo: 100, player1: "Mathis")
    }
}
