//
//  LoginService.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/12/2023.
//

import Foundation


class AuthService {
    
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
                
        guard let url = URL(string: ApiSettings.apiUrl + "/login") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(request)
            urlRequest.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // 1. Gestion des erreurs de réseau
            if let error = error {
                completion(.failure(error))
                return
            }

            // 2. Vérification de la réponse HTTP
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Réponse HTTP non valide"])))
                return
            }

            // 3. Gestion des codes de statut HTTP
            switch httpResponse.statusCode {
            case 201:
                // La connexion a réussi, poursuivre avec la réponse JSON
                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Pas de données"])))
                    return
                }

                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    UserDefaults.standard.set(loginResponse.token, forKey: "accessToken")
                    completion(.success(loginResponse))
                } catch {
                    completion(.failure(error))
                }
            case 401:
                
                // Authentification échouée
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Échec de l'authentification"])))
            default:
                // Autres codes de statut HTTP non gérés
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Réponse HTTP non valide avec le code \(httpResponse.statusCode)"])))
            }
        }.resume()

    }
}

