//
//  AuthManager.swift
//  Ranking
//
//  Created by Mathis Fleury on 30/12/2023.
//

import Foundation
import KeychainSwift

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    let keychain = KeychainSwift()
    @Published var isAuthenticated = false

    func setAccessToken(token: String) {
        keychain.set(token, forKey: "authToken")
        DispatchQueue.main.async {
            self.isAuthenticated = true
        }
        print("setAccessToken", self.isAuthenticated)
    }

    func getAccessToken() -> String? {
        keychain.get("authToken")
    }

    func clearAccessToken() {
        keychain.delete("authToken")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
        print("clearAccessToken", self.isAuthenticated)
    }

    func checkAuthentication() {
        if let token = keychain.get("authToken"), !token.isEmpty {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }

}
