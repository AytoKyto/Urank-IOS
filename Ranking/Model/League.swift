//
//  League.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//

import Foundation

struct ServerResponseLeagueShowSingel: Codable {
    let message: String
    let leagueData: [League]
    let userLeagueData: [LeagueUser]
    let duelData: [DuelUser]
    let globalStats: GlobalStats

    enum CodingKeys: String, CodingKey {
        case message,
             leagueData = "league_data",
             userLeagueData = "user_league_data",
             duelData = "duel_data",
             globalStats = "global_stats"
    }
}

struct ServerResponseDelete: Codable {
    let message: String
}

struct ServerResponseAddLeague: Codable {
    let message: String}

struct League: Codable {
    let id: Int
    let icon: String
    let name: String
    let adminUserId: Int?
    let createdAt: String?
    let updatedAt: String?
    let adminUser: User?

    enum CodingKeys: String, CodingKey {
        case id, icon, name, adminUserId = "admin_user_id", createdAt = "created_at", updatedAt = "updated_at", adminUser = "admin_user"
    }
}

struct LeagueRequest: Codable {
    let icon: String
    let name: String
}
