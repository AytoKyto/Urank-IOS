//
//  CardBattleView.swift
//  Ranking
//
//  Created by Mathis Fleury on 04/11/2023.
//

import SwiftUI

struct CardDuelView: View {
    let leagueTitle: String
    let scoreElo: Double
    let player1: String
    let player2: String
    
    init(leagueTitle: String, scoreElo: Double, player1: String, player2: String) {
        self.leagueTitle = leagueTitle
        self.scoreElo = scoreElo
        self.player1 = player1
        self.player2 = player2
    }
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("League")
                    .font(.footnote)
                    .foregroundColor(Color("PrimaryTextColor"))
                Text(leagueTitle)
                    .font(.title3)
            }
            Spacer()
            if scoreElo >= 0 {
                   Text("+\(String(format: "%.0f", scoreElo))")
                       .font(.title2)
                       .foregroundColor(.green)
               } else {
                   Text("\(String(format: "%.0f", scoreElo))")
                       .font(.title2)
                       .foregroundColor(.red)
               }
            Spacer()
            HStack() {
                let firstLetterP1 = String(player1.prefix(1)).uppercased()
                let lastLetterP1 = String(player1.suffix(1)).uppercased()
                let firstLetterP2 = String(player2.prefix(1)).uppercased()
                let lastLetterP2 = String(player2.suffix(1)).uppercased()
                
                Text(firstLetterP1 + lastLetterP1)
                    .foregroundColor(Color.black)
                    .frame(width: 45.0, height: 45.0)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(999.0)

                Text(firstLetterP2+lastLetterP2)
                    .foregroundColor(Color.black)
                    .frame(width: 45.0, height: 45.0)
                    .background(Color("PrimaryWhite"))
                    .cornerRadius(999.0)
            }
        }
        .padding(.all, 10.0)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("PrimaryGray"), lineWidth: 1.5)
        ) 
    }
}

struct CardBattleView_Previews: PreviewProvider {
    static var previews: some View {
        CardDuelView(leagueTitle: "Ping pong", scoreElo: 100, player1: "Mathis", player2: "Jeremy")
    }
}
