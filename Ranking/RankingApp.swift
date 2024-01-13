//
//  RankingApp.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/10/2023.
//

import SwiftUI

@main
struct RankingApp: App {
    var apiSettings = ApiSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(apiSettings)
        }
    }
}
