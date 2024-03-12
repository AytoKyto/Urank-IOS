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
            LeagueView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("League")
                }
            AddDuelView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Ajouter duel")
                }
            DuelView()
                .tabItem {
                    Image(systemName: "list.dash.header.rectangle")
                    Text("Duel")
                }
            DuelView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
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
