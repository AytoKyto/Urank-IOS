//
//  Duel.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//

import Foundation

struct Duel: Decodable {
    let id: Int
    let leagueId: Int
    let winnerUserId: Int
    let winnerScore: Int
    let winnerScoreValue: String
    let loserUserId: Int
    let loserScore: Int
    let loserScoreValue: String
    let description: String?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case leagueId = "league_id" // Correction ici
        case winnerUserId = "winner_user_id"
        case winnerScore = "winner_score"
        case winnerScoreValue = "winner_score_value"
        case loserUserId = "loser_user_id"
        case loserScore = "loser_score"
        case loserScoreValue = "loser_score_value"
        case description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
