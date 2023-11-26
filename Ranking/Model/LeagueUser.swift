//
//  LeagueUser.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//

import Foundation

struct LeagueUser: Decodable {
    let id: Int
    let userId: Int
    let leagueId: Int
    let elo: Int
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case leagueId = "league_id"
        case elo
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
