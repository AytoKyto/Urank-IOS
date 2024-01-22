//
//  LeagueUserViewModel.swift
//  Ranking
//
//  Created by Mathis Fleury on 13/01/2024.
//

import Foundation
import SwiftUI

class LeagueUserViewModel: ObservableObject {
    private let leagueUserService: LeagueUserService

    @Published var leagueUserShow: ServerResponseLeagueUserShow?
    @Published var usersInLeague: ServerResponseLeagueUserShow?

    @Published var isError: Bool = false

    init(leagueUserService: LeagueUserService = LeagueUserService()) {
        self.leagueUserService = leagueUserService
    }

    func getLeagueUserShow() {
        leagueUserService.getLeagueUserShow { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(responseGetLeagueUserShow):
                    self?.leagueUserShow = responseGetLeagueUserShow
                case .failure:
                    self?.isError = true
                    Alert(title: Text("Une erreur est survenue"))

                }
            }
        }
    }
    
    func getUsersInLeague(leagueId: Int) {
        leagueUserService.getUsersInLeague(leagueId: leagueId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(responseGetLeagueUserShow):
                    self?.usersInLeague = responseGetLeagueUserShow
                case .failure:
                    self?.isError = true
                    Alert(title: Text("Une erreur est survenue"))

                }
            }
        }
    }
}
