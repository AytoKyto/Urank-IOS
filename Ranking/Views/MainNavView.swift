//
//  MainNavView.swift
//  Ranking
//
//  Created by Mathis Fleury on 04/11/2023.
//

import SwiftUI

struct MainNavView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            AddDuelView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Ajouter duel")
                }
            LeagueView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("League")
                }
            BattelView()
                .tabItem {
                    Image(systemName: "list.dash.header.rectangle")
                    Text("Duel")
                }
        }
        .accentColor(Color("PrimaryColor"))
    }
}

struct MainNavView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavView()
    }
}
