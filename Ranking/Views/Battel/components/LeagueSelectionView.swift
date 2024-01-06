//
//  LeagueSelectionView.swift
//  Ranking
//
//  Created by Mathis Fleury on 06/01/2024.
//

import SwiftUI

struct LeagueSelectionView: View {
    @Binding var selectedLeague: Int
    let leagues = ["League A", "League B", "League C"]

    var body: some View {
        VStack {
            Picker("Select League", selection: $selectedLeague) {
                ForEach(0..<leagues.count) { index in
                    Text(leagues[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}
