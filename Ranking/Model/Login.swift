//
//  Login.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/12/2023.
//


// Model/LoginRequest.swift
struct LoginRequest: Codable {
    let email: String
    let password: String
}

// Model/LoginResponse.swift
struct LoginResponse: Codable {
    let token: String
}
