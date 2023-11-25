//
//  UserPayment.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//

import Foundation

struct UserPayment: Identifiable, Codable {
    var id: Int
    var userId: Int
    var status: String
    var montant: Double
    var méthode: String
}
