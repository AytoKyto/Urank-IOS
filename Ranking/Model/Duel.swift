//
//  Duel.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//

import Foundation

struct Duel: Identifiable, Codable {
    var id: Int
    var leagueId: Int
    var playerWinId: Int
    var scorePlayerWin: Int
    var scoreValueAddWin: Int
    var playerLoseId: Int
    var scorePlayerLose: Int
    var scoreValueAddLose: Int
    var description: String
}
