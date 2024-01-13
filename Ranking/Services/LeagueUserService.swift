//
//  LeagueUserService.swift
//  Ranking
//
//  Created by Mathis Fleury on 07/01/2024.
//

import Foundation

let headers = [
  "User-Agent": "insomnia/8.3.0",
  "Authorization": "Bearer 22|9i0dqIZgkzJmiHAAwRPxIZk3JwE6IBBpRwHZx0fy266e4f28"
]

class LeagueUserService {
    private var apiSettings: ApiSettings
    
    init(apiSettings: ApiSettings) {
        self.apiSettings = apiSettings
    }
    
    func getLeagueUserShow(completion: @escaping (Result<ServerResponseLeagueUserShow, Error>) -> Void) {
        
        guard let url = URL(string: apiSettings.apiUrl + "/league-users") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])))
            return
        }
          
        
    }
    
}
