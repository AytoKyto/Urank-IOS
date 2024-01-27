//
//  DashboardService.swift
//  Ranking
//
//  Created by Mathis Fleury on 25/11/2023.
//

import Foundation

enum DashboardError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case invalidResponse
    case authenticationFailed
}

class DashboardService {
    func getDashboardData(completion: @escaping (Result<ResponseDashboard, Error>) -> Void) {
        
        guard let url = URL(string: ApiSettings.apiUrl + "/dash") else {
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
                let responseGetLeagueUserShow = try decoder.decode(ResponseDashboard.self, from: data)
                print(responseGetLeagueUserShow)

                completion(.success(responseGetLeagueUserShow))

            } catch {
                print("Erreur de décodage : \(error)")
                completion(.failure(LeagueUserServiceError.decodingError))
            }
        }.resume()
    }
}

