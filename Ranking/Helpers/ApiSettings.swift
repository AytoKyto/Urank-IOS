//
//  ApiSettings.swift
//  Ranking
//
//  Created by Mathis Fleury on 02/01/2024.
//

import Foundation

class ApiSettings: ObservableObject {
    @Published var apiUrl: String = "http://rank-back.test/api"
}

