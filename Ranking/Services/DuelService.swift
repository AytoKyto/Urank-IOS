//
//  DuelService.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/01/2024.
//
import Foundation

enum DuelServiceError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case invalidResponse
    case authenticationFailed
}

class DuelService {
    func addNewDuel(request: DuelRequest, completion: @escaping (Result<messageResponse, Error>) -> Void) {
        // 1. Créez l'URL pour la requête
        guard let url = URL(string: ApiSettings.apiUrl + "/duels") else {
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
                print("Réponse HTTP non valide")
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
            default:
                // Autres codes de statut HTTP non gérés
                print("Réponse HTTP non valide avec le code \(httpResponse.statusCode)")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Réponse HTTP non valide avec le code \(httpResponse.statusCode)"])))
            }
        }.resume() // 9. Lancez la tâche URLSession
    }

    func getAllDuel(completion: @escaping (Result<ServerResponseDuel, Error>) -> Void) {
        guard let url = URL(string: ApiSettings.apiUrl + "/duels") else {
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
                completion(.failure(DuelServiceError.invalidResponse))
                return
            }

            // 3. Gestion des codes de statut HTTP
            guard httpResponse.statusCode == 200 else {
                switch httpResponse.statusCode {
                case 401:
                    completion(.failure(DuelServiceError.authenticationFailed))

                default:
                    completion(.failure(DuelServiceError.requestFailed))
                    print("Erreur de requestFailed : \(String(describing: error))")
                }
                return
            }

            // 4. Traitement des données reçues
            guard let data = data else {
                completion(.failure(DuelServiceError.invalidResponse))
                print("Erreur de invalidResponse : \(String(describing: error))")

                return
            }
            do {
                let responseGetLeagueUserShow = try JSONDecoder().decode(ServerResponseDuel.self, from: data)
                completion(.success(responseGetLeagueUserShow))
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Clé '\(key.stringValue)' manquante dans \(context.codingPath) - \(context.debugDescription)")
            } catch {
                print("Erreur de décodage: \(error)")
              completion(.failure(DuelServiceError.decodingError))
        }
        }.resume()
    }

    func getDetailDuelSingel(duelId: Int, completion: @escaping (Result<ServerResponseDetailDuel, Error>) -> Void) {
        guard let url = URL(string: ApiSettings.apiUrl + "/duels/\(duelId)") else {
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
                completion(.failure(DuelServiceError.invalidResponse))
                return
            }

            // 3. Gestion des codes de statut HTTP
            guard httpResponse.statusCode == 200 else {
                switch httpResponse.statusCode {
                case 401:
                    completion(.failure(DuelServiceError.authenticationFailed))

                default:
                    completion(.failure(DuelServiceError.requestFailed))
                    print("Erreur de requestFailed : \(String(describing: error))")
                }
                return
            }

            // 4. Traitement des données reçues
            guard let data = data else {
                completion(.failure(DuelServiceError.invalidResponse))
                print("Erreur de invalidResponse : \(String(describing: error))")

                return
            }

            do {
                let responseGetDetailDuel = try JSONDecoder().decode(ServerResponseDetailDuel.self, from: data)
                completion(.success(responseGetDetailDuel))
            } catch let DecodingError.keyNotFound(key, context) {
                print("Clé '\(key.stringValue)' manquante dans \(context.codingPath) - \(context.debugDescription)")
            } catch {
                print("Erreur de décodage: \(error)")
                completion(.failure(DuelServiceError.decodingError))
            }
        }.resume()
    }
}
