import SwiftUI

struct AddDuelView: View {
    @State private var selectedLeagueIndex: Int?
    @State private var isLeagueSelectionPresented = false
    @State private var selectedWinners: Set<Int> = []
    @State private var selectedLosers: Set<Int> = []
    @State private var duelDescription = ""
    @State private var isSummaryViewPresented = false

    // Déclaration de la variable leagues
    let leagues = ["League A", "League B", "League C", "League D", "League E"]

    var selectedLeagueBinding: Binding<String?> {
        Binding(
            get: { selectedLeagueIndex.map { leagues[$0] } },
            set: { newValue in
                if let index = leagues.firstIndex(of: newValue ?? "") {
                    selectedLeagueIndex = index
                    isLeagueSelectionPresented.toggle()
                } else {
                    selectedLeagueIndex = nil
                }
            }
        )
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Sélectionnez une ligue")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding()

                Button(action: { isLeagueSelectionPresented.toggle() }) {
                    Image(systemName: "magnifyingglass")
                    Text("Sélectionner une ligue")
                        .padding(.horizontal)
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                if selectedLeagueIndex != nil {
                    WinnersSelectionView(selectedWinners: $selectedWinners)
                        .padding()

                    LosersSelectionView(selectedLosers: $selectedLosers)
                        .padding()
                }

                TextField("Duel Description", text: $duelDescription)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Spacer()

                if selectedLeagueIndex != nil && !selectedWinners.isEmpty && !selectedLosers.isEmpty {

                    Button("Valider") {
                    }
                    .padding()
                    Button("Show Summary") {
                        isSummaryViewPresented.toggle()
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Créer une partie", displayMode: .inline)
        }
        .navigationBarTitle("", displayMode: .inline)
        .sheet(isPresented: $isLeagueSelectionPresented) {
            LeagueSelectionView(selectedLeague: selectedLeagueBinding)
        }
        .sheet(isPresented: $isSummaryViewPresented) {
            DuelSummaryView(selectedLeague: leagues[selectedLeagueIndex!],
                                                            selectedWinners: selectedWinners,
                                                            selectedLosers: selectedLosers,
                                                            duelDescription: duelDescription)
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
