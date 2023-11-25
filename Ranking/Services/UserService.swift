// UserService.swift
// Ranking
//
// Created by Mathis Fleury on 19/11/2023.

import Foundation

enum UserError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case invalidResponse
}

func getUser() async throws -> [User] {
    let endpoint = "http://rank-back.test/api/users"
    guard let url = URL(string: endpoint) else { throw UserError.invalidURL }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw UserError.invalidResponse
    }

    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let serverResponse = try decoder.decode(ServerResponse.self, from: data)
        return serverResponse.data
    } catch {
        print("Erreur de décodage : \(error)")
        throw UserError.decodingError
    }
}

