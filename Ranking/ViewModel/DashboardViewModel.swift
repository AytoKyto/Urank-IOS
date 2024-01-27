//
//  DashboardViewModel.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/01/2024.
//

import Foundation
import SwiftUI

class DashboardViewModel: ObservableObject {
    private let dashboardService: DashboardService
    
    @Published var responseDashboard: ResponseDashboard?
    @Published var isError: Bool = false
    
    init(dashboardService: DashboardService = DashboardService()) {
        self.dashboardService = dashboardService
    }
    
    func getDashboardData() {
        dashboardService.getDashboardData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(responseDashboard):
                    self?.responseDashboard = responseDashboard
                case .failure:
                    self?.isError = true
                }
            }
        }
    }
}
