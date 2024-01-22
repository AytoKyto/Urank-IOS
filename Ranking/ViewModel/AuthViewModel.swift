//
//  AuthViewModel.swift
//  Ranking
//
//  Created by Mathis Fleury on 30/12/2023.
//

import Foundation

class AuthViewModel: ObservableObject {
    let authService = AuthService()

    func login(request: LoginRequest, completion: @escaping (Bool) -> Void) {
        authService.login(request: request) { result in
            switch result {
            case let .success(loginResponse):
                // Stocker le token d'authentification de manière sécurisée
                AuthManager.shared.setAccessToken(token: loginResponse.token)
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}
