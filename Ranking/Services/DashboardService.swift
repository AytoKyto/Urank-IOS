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
}

func getDashboard() async throws -> Dashboard { // Modifiez le type de retour pour correspondre à DashboardServerResponse
    let endpoint = "http://rank-back.test/api/dash/user_id=1"
    guard let url = URL(string: endpoint) else { throw DashboardError.invalidURL }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw DashboardError.invalidResponse
    }

    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let serverResponse = try decoder.decode(Dashboard.self, from: data)
        return serverResponse
    } catch {
        print("Erreur de décodage : \(error)")
        throw DashboardError.decodingError
    }
}
