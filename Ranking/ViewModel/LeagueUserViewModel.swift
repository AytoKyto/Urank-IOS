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
    @Published var leagueDetailSingel: ServerResponseLeagueShowSingel?

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
                }
            }
        }
    }

    func addUsersInLeague(request: UserInLeagueRequest, completion: @escaping (Bool) -> Void) {
        leagueUserService.addUsersInLeague(request: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion(true)
                case .failure:
                    self?.isError = true
                }
            }
        }
    }

    func deleteUsersInLeague(userId: Int, leagueId: Int) {
        leagueUserService.deleteUsersInLeague(userId: userId, leagueId: leagueId) {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(responseDeleteLeagueUser): break
                case .failure:
                    self?.isError = true
                }
            }
        }
    }
}
