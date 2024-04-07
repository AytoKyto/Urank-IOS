// UserService.swift
// Ranking
//
// Created by Mathis Fleury on 19/11/2023.

import Foundation
import SwiftUI

enum UserError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case invalidResponse
    case authenticationFailed
}

class UserService {
    func getMyProfile(completion: @escaping (Result<MyProfileServerResponse, Error>) -> Void) {
        guard let url = URL(string: ApiSettings.apiUrl + "/my-profile") else {
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
                completion(.failure(UserError.invalidResponse))
                return
            }

            // 3. Gestion des codes de statut HTTP
            guard httpResponse.statusCode == 200 else {
                switch httpResponse.statusCode {
                case 401:
                    completion(.failure(UserError.authenticationFailed))

                default:
                    completion(.failure(UserError.requestFailed))
                    print("Erreur de requestFailed : \(String(describing: error))")
                }
                return
            }

            // 4. Traitement des données reçues
            guard let data = data else {
                completion(.failure(UserError.invalidResponse))
                print("Erreur de invalidResponse : \(String(describing: error))")
                return
            }
            do {
                let responseMyProfile = try JSONDecoder().decode(MyProfileServerResponse.self, from: data)
                completion(.success(responseMyProfile))
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Clé '\(key.stringValue)' manquante dans \(context.codingPath) - \(context.debugDescription)")
            } catch {
                print("Erreur de décodage : \(error)")
                completion(.failure(UserError.decodingError))
            }
        }.resume()
    }
}

