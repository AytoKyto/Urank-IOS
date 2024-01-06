import SwiftUI

struct AddDuelView: View {
    @State private var selectedLeague = 0
    @State private var selectedWinners: Set<Int> = []
    @State private var selectedLosers: Set<Int> = []
    @State private var duelDescription = ""
    @State private var isSummaryViewPresented = false

    // Déclaration de la variable leagues
    let leagues = ["League A", "League B", "League C"]

    var body: some View {
        NavigationView {
            VStack {
                LeagueSelectionView(selectedLeague: $selectedLeague)
                    .padding()

                if selectedLeague >= 0 {
                    WinnersSelectionView(selectedWinners: $selectedWinners)
                        .padding()

                    LosersSelectionView(selectedLosers: $selectedLosers)
                        .padding()
                }

                TextField("Duel Description", text: $duelDescription)
                    .padding()

                Spacer()

                if selectedLeague >= 0 && !selectedWinners.isEmpty && !selectedLosers.isEmpty {
                    NavigationLink("", destination: DuelSummaryView(selectedLeague: leagues[selectedLeague],
                                                                    selectedWinners: selectedWinners,
                                                                    selectedLosers: selectedLosers,
                                                                    duelDescription: duelDescription),
                                   isActive: $isSummaryViewPresented)
                        .opacity(0)

                    Button("Show Summary") {
                        isSummaryViewPresented.toggle()
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Add Duel", displayMode: .inline)
        }
    }
}

struct Player {
    let name: String
    let isWinner: Bool
}

struct AddDuelView_Previews: PreviewProvider {
    static var previews: some View {
        AddDuelView()
    }
}
