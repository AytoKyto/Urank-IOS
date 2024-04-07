//
//  InvitationsUser.swift
//  Ranking
//
//  Created by Mathis Fleury on 16/03/2024.
//

import Foundation

struct ServerResponseInvitationsUser: Decodable {
    let message: String
    let data: [InvitationsUser]
}

struct InvitationsUser: Codable, Identifiable {
    var id: Int { userId } // Using userId as the unique identifier
    
    let userId: Int
    let invitedUserId: Int
    let user: User
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case invitedUserId = "invited_user_id"
        case user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

