//
//  User.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//
import Foundation

struct ServerResponse: Codable {
    let message: String
    let data: [User]
}

struct MyProfileServerResponse: Codable {
    let message: String
    let user: User
    let userStats: UserStats // This should be 'UserStats' not 'userStats'
    
    enum CodingKeys: String, CodingKey {
        case message, user
        case userStats = "user_stats"
    }
}

struct UserStats: Codable { // The struct name should start with an uppercase letter
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

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let emailVerifiedAt: String?
    let coins: Int
    let status: String
    let type: Int
    let avatar: String?
    let bgColor: String?
    let bgAvatar: String?
    let borderAvatar: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, coins, status, type, avatar
        case emailVerifiedAt = "email_verified_at"
        case bgColor = "bg_color"
        case bgAvatar = "bg_avatar"
        case borderAvatar = "border_avatar"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct Player {
    let name: String
    let isWinner: Bool
}

