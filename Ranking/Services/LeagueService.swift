//
//  LeagueService.swift
//  Ranking
//
//  Created by Mathis Fleury on 14/03/2024.
//

import Foundation
import SwiftUI

enum LeagueServiceError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case invalidResponse
    case authenticationFailed
    case invalidData
}


class LeagueService {
    func getDetailLeagueSingel(leagueId: Int, completion: @escaping (Result<ServerResponseLeagueShowSingel, Error>) -> Void) {
        guard let url = URL(string: ApiSettings.apiUrl + "/leagues/\(leagueId)") else {
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
                let responseGetLeagueShowSingel = try JSONDecoder().decode(ServerResponseLeagueShowSingel.self, from: data)
                completion(.success(responseGetLeagueShowSingel))
            } catch let DecodingError.keyNotFound(key, context) {
                print("Clé '\(key.stringValue)' manquante dans \(context.codingPath) - \(context.debugDescription)")
            } catch {
                print("Erreur de décodage: \(error)")
                completion(.failure(LeagueUserServiceError.decodingError))
            }
        }.resume()
    }
    
    func postAddLeague(request: LeagueRequest, completion: @escaping (Result<ServerResponseAddLeague, Error>) -> Void) {
        guard let url = URL(string: ApiSettings.apiUrl + "/leagues") else {
            completion(.failure(LeagueServiceError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.allHTTPHeaderFields = ApiSettings.apiHeaders
        
        do {
            let jsonData = try JSONEncoder().encode(request)
            urlRequest.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(LeagueServiceError.invalidResponse))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                switch httpResponse.statusCode {
                case 401:
                    completion(.failure(LeagueServiceError.authenticationFailed))
                default:
                    completion(.failure(LeagueServiceError.requestFailed))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(LeagueServiceError.invalidData))
                return
            }
            
            do {
                let responseAddLeague = try JSONDecoder().decode(ServerResponseAddLeague.self, from: data)
                completion(.success(responseAddLeague))
            } catch {
                completion(.failure(LeagueServiceError.decodingError))
            }
        }.resume()
    }
    
    func deleteLeague(leagueId: Int, completion: @escaping (Result<ServerResponseDelete, Error>) -> Void) {
        guard let url = URL(string: ApiSettings.apiUrl + "/leagues/\(leagueId)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])))
            return
        }
        
        print(ApiSettings.apiUrl + "/leagues/\(leagueId)")

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
