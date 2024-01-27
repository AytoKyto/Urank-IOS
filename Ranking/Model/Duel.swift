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
        case leagueId = "league_id"
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

struct DuelRequest: Codable {
    let leagueId: Int?
    let isNull: Bool?
    let description: String?
    let winUser: [UserInLeagueIdElo]?
    let loseUser: [UserInLeagueIdElo]?
    
    enum CodingKeys: String, CodingKey {
        case leagueId = "league_id"
        case isNull = "is_null"
        case description
        case winUser = "win_user"
        case loseUser = "lose_user"
    }
}

struct DuelData: Codable {
    let id: Int
    let userId: Int?
    let duelId: Int?
    let leagueId: Int?
    let leagueUserEloInit: Int?
    let leagueUserEloAdd: Int?
    let coin: Int
    let status: Int
    let createdAt: String?
    let updatedAt: String?
    let user: User
    let league: League

    enum CodingKeys: String, CodingKey {
            case id
            case userId = "user_id"
            case duelId = "duel_id"
            case leagueId = "league_id"
            case leagueUserEloInit = "league_user_elo_init"
            case leagueUserEloAdd = "league_user_elo_add"
            case coin
            case status
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case user
            case league
        }
}
