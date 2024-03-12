//
//  LeagueViewModel.swift
//  Ranking
//
//  Created by Mathis Fleury on 14/03/2024.
//

import Foundation
import SwiftUI

class LeagueViewModel: ObservableObject {
    private let leagueService: LeagueService

    @Published var leagueDetailSingel: ServerResponseLeagueShowSingel?

    @Published var isError: Bool = false

    init(leagueService: LeagueService = LeagueService()) {
        self.leagueService = leagueService
    }

    func getDetailLeagueSingel(leagueId: Int) {
        leagueService.getDetailLeagueSingel(leagueId: leagueId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(responseGetLeagueShowSingel):
                    self?.leagueDetailSingel = responseGetLeagueShowSingel
                case .failure:
                    self?.isError = true
                }
            }
        }
    }

    func leagueAdd(request: LeagueRequest, completion: @escaping (Bool) -> Void) {
        leagueService.postAddLeague(request: request) { [weak self] result in
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
    
    func deleteLeague(leagueId: Int) {
        leagueService.deleteLeague(leagueId: leagueId) {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(_): break
                case .failure:
                    self?.isError = true
                }
            }
        }
    }
}
