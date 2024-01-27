//
//  DuelService.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/01/2024.
//
import Foundation

class DuelService {
    func addNewDuel(request: DuelRequest, completion: @escaping (Result<messageResponse, Error>) -> Void) {
        // 1. Créez l'URL pour la requête
        guard let url = URL(string: ApiSettings.apiUrl + "/duels") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])))
            return
        }
        print("URL créée: \(url)")

        // 2. Configurez la requête HTTP
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.allHTTPHeaderFields = ApiSettings.apiHeaders

        // 3. Encodez l'objet DuelRequest en JSON
        if let jsonData = try? JSONEncoder().encode(request),
           let jsonString = String(data: jsonData, encoding: .utf8) {
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
}
