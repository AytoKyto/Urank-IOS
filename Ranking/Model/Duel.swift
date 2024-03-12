//
//  Duel.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//
import Foundation

// Represents a server response that includes a message and an array of DuelData
struct ServerResponseDuel: Codable {
    let message: String
    let data: [DuelData]
}

// Represents detailed information about a duel including associated users and main duel user
struct ServerResponseDetailDuel: Decodable {
    let message: String
    let duel: DuelInfo
    let duelUsers: [DuelData]
    let nbrUsers: Int
    let duelUserMain: DuelData
    let winners: [DuelData]
    let losers: [DuelData]


    enum CodingKeys: String, CodingKey {
        case message
        case duel
        case duelUsers = "duel_users"
        case nbrUsers = "nbr_users"
        case duelUserMain = "duel_user_main"
        case winners
        case losers
    }
}

// Contains information about a duel including IDs and timestamps
struct DuelInfo: Decodable {
    let id: Int
    let leagueId: Int
    let authorId: Int
    let description: String?
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case leagueId = "league_id"
        case authorId = "author_id"
        case description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// Defines a duel including participants' IDs, scores, and timestamps
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

// Represents a request to create or update a duel, including optional user lists for winners and losers
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

// A structure to hold a DuelData instance, likely for request purposes
struct DuelUser: Codable {
    let duel: DuelData
}

// Represents the data associated with a duel, including user and league information
struct DuelData: Codable {
    let id: Int
    let userId: Int?
    let duelId: Int
    let leagueId: Int?
    let leagueUserEloInit: Int
    let leagueUserEloAdd: Int
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
