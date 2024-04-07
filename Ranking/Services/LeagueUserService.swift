//
//  LeagueUserService.swift
//  Ranking
//
//  Created by Mathis Fleury on 07/01/2024.
//

import Foundation
import SwiftUI

enum LeagueUserServiceError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case invalidResponse
    case authenticationFailed
}

class LeagueUserService {
    func getLeagueUserShow(completion: @escaping (Result<ServerResponseLeagueUserShow, Error>) -> Void) {
        guard let url = URL(string: ApiSettings.apiUrl + "/league-users") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.allHTTPHeaderFields = ApiSettings.apiHeaders

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // 1. Gestion des erreurs de réseau
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }

            // 2. Vérification de la réponse HTTP
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(LeagueUserServiceError.invalidResponse))
                return
            }

            // 3. Gestion des codes de statut HTTP
            guard httpResponse.statusCode == 200 else {
                switch httpResponse.statusCode {
                case 401:
                    completion(.failure(LeagueUserServiceError.authenticationFailed))

                default:
                    completion(.failure(LeagueUserServiceError.requestFailed))
                    print("Erreur de requestFailed : \(String(describing: error))")
                }
                return
            }

            // 4. Traitement des données reçues
            guard let data = data else {
                completion(.failure(LeagueUserServiceError.invalidResponse))
                print("Erreur de invalidResponse : \(String(describing: error))")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseGetLeagueUserShow = try decoder.decode(ServerResponseLeagueUserShow.self, from: data)
                completion(.success(responseGetLeagueUserShow))

            } catch {
                print("Erreur de décodage : \(error)")
                completion(.failure(LeagueUserServiceError.decodingError))
            }
        }.resume()
    }

    func getUsersInLeague(leagueId: Int, completion: @escaping (Result<ServerResponseLeagueUserShow, Error>) -> Void) {
        guard let url = URL(string: ApiSettings.apiUrl + "/users-in-league/\(leagueId)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.allHTTPHeaderFields = ApiSettings.apiHeaders

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // 1. Gestion des erreurs de réseau
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }

            // 2. Vérification de la réponse HTTP
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(LeagueUserServiceError.invalidResponse))
                return
            }

            // 3. Gestion des codes de statut HTTP
            guard httpResponse.statusCode == 200 else {
                switch httpResponse.statusCode {
                case 401:
                    completion(.failure(LeagueUserServiceError.authenticationFailed))

                default:
                    completion(.failure(LeagueUserServiceError.requestFailed))
                    print("Erreur de requestFailed : \(String(describing: error))")
                }
                return
            }

            // 4. Traitement des données reçues
            guard let data = data else {
                completion(.failure(LeagueUserServiceError.invalidResponse))
                print("Erreur de invalidResponse : \(String(describing: error))")

                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseGetLeagueUserShow = try decoder.decode(ServerResponseLeagueUserShow.self, from: data)
                completion(.success(responseGetLeagueUserShow))
            } catch {
                print("Erreur de décodage : \(error)")
                completion(.failure(LeagueUserServiceError.decodingError))
            }
        }.resume()
    }
    
    func addUsersInLeague(request: UserInLeagueRequest, completion: @escaping (Result<messageResponse, Error>) -> Void) {
        
        print(request)
        // 1. Créez l'URL pour la requête
        guard let url = URL(string: ApiSettings.apiUrl + "/league-users") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])))
            return
        }

        // 2. Configurez la requête HTTP
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.allHTTPHeaderFields = ApiSettings.apiHeaders

        // 3. Encodez l'objet DuelRequest en JSON
        if let jsonData = try? JSONEncoder().encode(request),
           let _ = String(data: jsonData, encoding: .utf8) {
            urlRequest.httpBody = jsonData
            
        } else {
            // Gérez l'erreur si la conversion échoue
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Erreur lors de la conversion des données JSON"])))
            return
        }

        // 4. Envoyez la requête HTTP
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // 5. Gérez les erreurs de réseau
            if let error = error {
                print("Erreur réseau: \(error)")
                completion(.failure(error))
                return
            }

            // 6. Vérifiez la réponse HTTP
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Réponse HTTP non valide"])))
                return
            }

            // 7. Gérez les codes de statut HTTP
            switch httpResponse.statusCode {
            case 201:
                // La connexion a réussi, poursuivre avec la réponse JSON
                guard let data = data else {
                    print("Pas de données dans la réponse")
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Pas de données"])))
                    return
                }

                do {
                    // 8. Décodez la réponse JSON en objet messageResponse
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let messageServResponse = try decoder.decode(messageResponse.self, from: data)
                    completion(.success(messageServResponse))
                } catch {
                    // Gérez l'erreur si le décodage échoue
                    print("Erreur de décodage JSON: \(error)")
                    completion(.failure(error))
                }
            case 401:
                // Authentification échouée
                print("Échec de l'authentification")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Échec de l'authentification"])))
            case 500:
                // Server-side error
                print("Server error")
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let messageServResponse = try decoder.decode(messageResponse.self, from: data!)
                    print(messageServResponse)

                    // Providing a more descriptive error to the caller
                    completion(.failure(NSError(domain: "com.yourapp.networking", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server error: \(messageServResponse.message)"])))
                } catch {
                    // Handling decoding error
                    print("Decoding error: \(error)")
                    completion(.failure(NSError(domain: "com.yourapp.networking", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server error and failed to decode response"])))
                }

            default:
                // Autres codes de statut HTTP non gérés
                print("Réponse HTTP non valide avec le code \(httpResponse.statusCode)")
                print(error)
                print(httpResponse)

                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Réponse HTTP non valide avec le code \(httpResponse.statusCode)"])))
            }
        }.resume() // 9. Lancez la tâche URLSession
    }

    func deleteUsersInLeague(userId: Int, leagueId: Int, completion: @escaping (Result<ServerResponseLeagueUserDelete, Error>) -> Void) {
        guard let url = URL(string: ApiSettings.apiUrl + "/league-users/\(userId)/\(leagueId)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])))
            return
        }
        
        print(ApiSettings.apiUrl + "/league-users/\(userId)/\(leagueId)")

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.allHTTPHeaderFields = ApiSettings.apiHeaders

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // 1. Gestion des erreurs de réseau
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }

            // 2. Vérification de la réponse HTTP
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(LeagueUserServiceError.invalidResponse))
                return
            }

            // 3. Gestion des codes de statut HTTP
            guard httpResponse.statusCode == 204 else {
                switch httpResponse.statusCode {
                case 401:
                    completion(.failure(LeagueUserServiceError.authenticationFailed))

                default:
                    completion(.failure(LeagueUserServiceError.requestFailed))
                    print("Erreur de requestFailed : \(String(describing: error))")
                    print("Erreur de requestFailed : \(String(describing: httpResponse.statusCode))")

                }
                return
            }
        }.resume()
    }
}

