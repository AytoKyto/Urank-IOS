//
//  Dashboard.swift
//  Ranking
//
//  Created by Mathis Fleury on 25/11/2023.
//
struct Dashboard: Decodable {
    let status: Bool
    let message: String
    let leagueUserData: [LeagueUser]?
    let duelData: [Duel]?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case leagueUserData = "league_user_data"
        case duelData = "duel_data"
    }
}
