//
//  CardLeagueView.swift
//  Ranking
//
//  Created by Mathis Fleury on 02/11/2023.
//

import SwiftUI

struct CardLeagueView: View {
    let title: String
    let icon: String
    let eloPlayer: Double
    let eloBestPlayer: Double

    init(title: String, icon: String, eloPlayer: Double, eloBestPlayer: Double) {
        self.title = title
        self.icon = icon
        self.eloPlayer = eloPlayer
        self.eloBestPlayer = eloBestPlayer
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(icon)
                    .font(.title3)
                    .padding(.vertical, 5.0)
                
                Text(title)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color("PrimaryTextColor"))
            }
            Text(String(format: "%.0f", eloPlayer))
                .font(.body)
                .fontWeight(.black)
                .foregroundColor(Color("PrimaryTextColor"))
            
            ProgressView(value: eloPlayer, total: eloBestPlayer)
                .progressViewStyle(LinearProgressViewStyle(tint: Color("PrimaryColor")))
                .scaleEffect(x: 1, y: 2, anchor: .center)

        }
        .padding(.all, 10.0)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("PrimaryGray"), lineWidth: 1.5)
        ) 
    }
}

struct CardLeagueView_Previews: PreviewProvider {
    static var previews: some View {
        CardLeagueView(title: "LA Ping pong", icon: "🏀", eloPlayer: 1000, eloBestPlayer: 2000)
    }
}
