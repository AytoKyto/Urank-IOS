//
//  LeagueSelectionView.swift
//  Ranking
//
//  Created by Mathis Fleury on 06/01/2024.
//

import SwiftUI

struct LeagueSelectionView: View {
    @Binding var selectedLeague: String?
    let leagues = ["League A", "League B", "League C"]

    var body: some View {
        List(leagues, id: \.self) { league in
            Button(action: {
                selectedLeague = league
            }) {
                Text(league)
            }
        }
        .navigationBarTitle("Sélectionner une ligue", displayMode: .inline)
    }
}

struct LeagueSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueSelectionView(selectedLeague: .constant(nil))
    }
}
