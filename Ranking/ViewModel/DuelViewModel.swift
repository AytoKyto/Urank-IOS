//
//  DuelViewModel.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/01/2024.
//


import Foundation
import SwiftUI

class DuelViewModel: ObservableObject {
    private let duelService: DuelService

    @Published var responseDuelAll: ServerResponseDuel?
    @Published var duelDetailSingel: ServerResponseDetailDuel?

    @Published var isError: Bool = false

    init() {
        self.duelService = DuelService() // Initialize DuelService here
    }

    func getAllDuel() {
        duelService.getAllDuel { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(serverResponseDuel):
                    self?.responseDuelAll = serverResponseDuel
                case .failure:
                    self?.isError = true
                }
            }
        }
    }

    func duelAdd(request: DuelRequest, completion: @escaping (Bool) -> Void) {
        duelService.addNewDuel(request: request) { [weak self] result in
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
    
    func getDetailDuelSingel(duelId: Int) {
        duelService.getDetailDuelSingel(duelId: duelId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(responseGetDetailDuel):
                    self?.duelDetailSingel = responseGetDetailDuel
                case .failure:
                    self?.isError = true
                }
            }
        }
    }
}
