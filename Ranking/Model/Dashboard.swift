//
//  Dashboard.swift
//  Ranking
//
//  Created by Mathis Fleury on 25/11/2023.
//

import Foundation

struct ResponseDashboard: Codable {
    let message: String
    let globalStats: GlobalStats?
    let league: [LeagueDashGroupe]
    let duelData: [DuelDataGroupe]?

    private enum CodingKeys: String, CodingKey {
        case message
        case league
        case globalStats = "global_stats"
        case duelData = "duel_data"
    }
    
}


struct GlobalStats: Codable {
    let userId: Int
    let nbDuel: Int
    let nbWin: String
    let nbLose: String
    let nbNull: String
    let winRate: String

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case nbDuel = "nb_duel"
        case nbWin = "nb_win"
        case nbLose = "nb_lose"
        case nbNull = "nb_null"
        case winRate = "win_rate"
    }
}

struct LeagueDashGroupe: Codable {
    let duel: LeagueUser
    let nbrUser: Int?
    let duelsUsers: [LeagueUser]?

    enum CodingKeys: String, CodingKey {
        case duel
        case nbrUser = "nbr_user"
        case duelsUsers = "duels_users"
    }
}

struct DuelDataGroupe: Codable {
    let duel: DuelData
    let nbrUser: Int?
    let duelsUsers: [DuelData]?

    enum CodingKeys: String, CodingKey {
        case duel
        case nbrUser = "nbr_user"
        case duelsUsers = "duels_users"
    }
}
