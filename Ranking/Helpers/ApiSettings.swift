//
//  ApiSettings.swift
//  Ranking
//
//  Created by Mathis Fleury on 02/01/2024.
//

import Foundation

struct ApiSettings {
    static let apiUrl = "http://rank-back.test/api"

    static var apiHeaders: [String: String] {
        if let accessToken = AuthManager.shared.getAccessToken() {
            return ["Authorization": "Bearer " + accessToken]
        } else {
            // Gérer le cas où le token n'est pas disponible
            return ["Authorization": "Bearer "]
        }
    }

    // ... Autres configurations ...
}
