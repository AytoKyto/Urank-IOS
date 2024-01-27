//
//  DuelViewModel.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/01/2024.
//

import Foundation
import SwiftUI

class DuelViewModel: ObservableObject {  // Use 'ObservableObject' instead of 'ObservedObject'
    private let duelService: DuelService
    
    @Published var isError: Bool = false

    init(duelService: DuelService) {
        self.duelService = duelService
    }

    func duelAdd(request: DuelRequest, completion: @escaping (Bool) -> Void) {
        duelService.addNewDuel(request: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    completion(true)
                case .failure:
                    self?.isError = true
                    // Do not present the alert here, just update the state
                }
            }
        }
    }
}
