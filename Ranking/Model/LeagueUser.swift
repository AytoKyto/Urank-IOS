//
//  LeagueUser.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//

import Foundation

struct LeagueUser: Identifiable, Codable {
    var id: Int
    var userId: Int
    var leagueId: Int
    var elo: Int
}
