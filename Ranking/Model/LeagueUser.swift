//
//  LeagueUser.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//

import Foundation

struct ServerResponseLeagueUserShow: Decodable {
    let message: String
    let data: [LeagueUser]
}

struct LeagueUserShowRequest: Codable {
    let id: Int
}

struct LeagueUser: Decodable {
    let id: Int
    let userId: Int
    let leagueId: Int
    let elo: Int
    let ranking: Int
    let type: Int
    let createdAt: String?
    let updatedAt: String?
    let user: [User]
    let league: [League]

    enum CodingKeys: String, CodingKey {
        case id, elo, ranking, type, user, league
        case userId = "user_id"
        case leagueId = "league_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
