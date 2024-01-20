//
//  LeagueUserService.swift
//  Ranking
//
//  Created by Mathis Fleury on 07/01/2024.
//

import Foundation

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
                    print(LeagueUserServiceError.authenticationFailed)

                default:
                    completion(.failure(LeagueUserServiceError.requestFailed))
                    print("Erreur de requestFailed : \(error)")

                }
                return
            }
            
            // 4. Traitement des données reçues
            guard let data = data else {
                completion(.failure(LeagueUserServiceError.invalidResponse))
                print("Erreur de invalidResponse : \(error)")

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
    
    func getUsersInLeague(completion: @escaping (Result<ServerResponseLeagueUserShow, Error>) -> Void) {
        
        guard let url = URL(string: ApiSettings.apiUrl + "users-in-league/1") else {
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
                    print(LeagueUserServiceError.authenticationFailed)

                default:
                    completion(.failure(LeagueUserServiceError.requestFailed))
                    print("Erreur de requestFailed : \(error)")

                }
                return
            }
            
            // 4. Traitement des données reçues
            guard let data = data else {
                completion(.failure(LeagueUserServiceError.invalidResponse))
                print("Erreur de invalidResponse : \(error)")

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
}
