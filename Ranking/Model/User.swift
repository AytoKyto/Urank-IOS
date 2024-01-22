//
//  User.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//
import Foundation

struct ServerResponse: Decodable {
    let message: String
    let data: [User]
}

struct User: Decodable {
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
