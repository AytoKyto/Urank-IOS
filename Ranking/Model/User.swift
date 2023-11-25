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
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

