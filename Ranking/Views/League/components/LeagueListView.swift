//
//  LeagueListView.swift
//  Ranking
//
//  Created by Mathis Fleury on 04/11/2023.
//

import SwiftUI

struct LeagueListView: View {
    var body: some View {
            HStack {
                Text("🏀")
                    .font(.title)
                    .frame(width: 50.0, height: 50.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 999)
                            .stroke(Color("PrimaryTextColor"), lineWidth: 1)
                    )
                    .background(.regularMaterial)
                    .cornerRadius(999.0)
                
                VStack(alignment: .leading) {
                    Text("Title")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryTextColor"))
                    
                    Text("2 players")
                        .font(.body)
                        .font(.title)
                        .fontWeight(.thin)
                        .foregroundColor(Color("PrimaryTextColor"))
                }
                Spacer()
                
                Text("1000")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("PrimaryTextColor"))
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
        }
    
}

struct LeagueListView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueListView()
    }
}

