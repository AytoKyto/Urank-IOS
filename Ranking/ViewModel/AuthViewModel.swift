//
//  AuthViewModel.swift
//  Ranking
//
//  Created by Mathis Fleury on 30/12/2023.
//

import Foundation

class AuthViewModel {
    private var authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    func login(request: LoginRequest, completion: @escaping (Bool) -> Void) {
        authService.login(request: request) { result in
            switch result {
            case .success(let loginResponse):
                // Stocker le token d'authentification de manière sécurisée
                AuthManager.shared.setAccessToken(token: loginResponse.token)
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
}

