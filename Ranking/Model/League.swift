//
//  League.swift
//  Ranking
//
//  Created by Mathis Fleury on 19/11/2023.
//

import Foundation

struct League: Identifiable, Codable {
    var id: Int
    var icon: String
    var name: String
    var adminUserId: Int
}
