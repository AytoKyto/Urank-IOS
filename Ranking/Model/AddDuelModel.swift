//
//  AddDuelModel.swift
//  Ranking
//
//  Created by Mathis Fleury on 20/01/2024.
//

import Foundation

struct ServerResponseAddDuelShow: Decodable {
    let message: String
    let data: [[LeagueUser]]
}
