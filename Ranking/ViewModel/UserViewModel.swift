//
//  UserViewModel.swift
//  Ranking
//
//  Created by Mathis Fleury on 07/04/2024.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    private let userService: UserService
    
    // Assuming MyProfileServerResponse is a struct and can be initialized with default values.
    // If not, it should be an optional type (`MyProfileServerResponse?`)
    @Published var myProfile: MyProfileServerResponse?

    // Instead of a boolean flag, consider using an enum with associated values for different error states
    @Published var error: Error?

    init(userService: UserService = UserService()) {
        self.userService = userService
    }

    /// Retrieves the user's league details.
    func getDetailLeague() {
        userService.getMyProfile() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseGetMyProfile):
                    self?.myProfile = responseGetMyProfile
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}
