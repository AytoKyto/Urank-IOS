//
//  ContentView.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/10/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authManager = AuthManager.shared // Utilisez AuthManager.shared pour partager la même instance

    var body: some View {
        Group {
            if authManager.isAuthenticated {
                MainNavView() // Vue principale de votre application
            } else {
                AuthMainNav()
            }
        }
        .onAppear {
            authManager.checkAuthentication()
            print(authManager.isAuthenticated)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
