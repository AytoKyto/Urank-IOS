//
//  InvitationsUserViewModel.swift
//  Ranking
//
//  Created by Mathis Fleury on 16/03/2024.
//

import Foundation
import SwiftUI

class InvitationsUserViewModel: ObservableObject {
    private let invitationsUserService: InvitationsUserService

    @Published var responseInvitationsUser: ServerResponseInvitationsUser?

    @Published var isError: Bool = false

    init() {
        self.invitationsUserService = InvitationsUserService() // Initialize DuelService here
    }

    func getAllInvitationsUser() {
        invitationsUserService.getAllInvitationsUser { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(responseInvitationsUser):
                    self?.responseInvitationsUser = responseInvitationsUser
                case .failure:
                    self?.isError = true
                }
            }
        }
    }
}
