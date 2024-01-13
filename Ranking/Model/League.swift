//
//  League.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//

import Foundation

struct League: Decodable {
    let id: Int
    let icon: String
    let name: String
    let adminUserId: Int
    let createdAt: String?
    let updatedAt: String?
    let admin_user: [User]

    enum CodingKeys: String, CodingKey {
        case id, icon, name, admin_user
        case adminUserId = "admin_user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
