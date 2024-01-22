import SwiftUI

struct AddDuelView: View {
    @StateObject private var leagueUserViewModel = LeagueUserViewModel()

    @State private var selectedLeagueIndex: Int?
    @State private var isLeagueSelectionPresented = false
    @State private var selectedWinners: Set<Int> = []
    @State private var selectedLosers: Set<Int> = []
    @State private var duelDescription = ""
    @State private var isSummaryViewPresented = false


    var selectedLeagueBinding: Binding<String?> {
        Binding(
            get: {
                guard let id = selectedLeagueIndex,
                      let leagues = leagueUserViewModel.leagueUserShow?.data,
                      let index = leagues.firstIndex(where: { $0.league.id == id }) else {
                    return nil
                }
                let league = leagues[index].league
                return league.icon + " " + league.name
            },
            set: { newValue in
                if let newValue = newValue,
                   let leagues = leagueUserViewModel.leagueUserShow?.data,
                   let index = leagues.firstIndex(where: { $0.league.name == newValue }) {
                    selectedLeagueIndex = leagues[index].league.id
                } else {
                    selectedLeagueIndex = nil
                }
                isLeagueSelectionPresented = false // Consider setting to false explicitly if needed
            }
        )
    }


    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                if let leagueUserShow = leagueUserViewModel.leagueUserShow {
                               // Afficher les données de leagueUserShow
                           } else if leagueUserViewModel.isError {
                               Text("Une erreur est survenue.")
                           } else {
                               Text("Chargement...")
                           }
                Text(leagueUserViewModel.leagueUserShow?.message ?? "Chargement...")
                
                Text(selectedLeagueBinding.wrappedValue ?? "Sélectionnez une ligue")
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
                    if let leagueData = leagueUserViewModel.usersInLeague?.data {
                        WinnersSelectionView(selectedWinners: $selectedWinners, usersData: leagueData)
                            .padding()
                    } else {
                        Text("No users data available")
                    }
                    
                    if let leagueData = leagueUserViewModel.usersInLeague?.data {
                        LosersSelectionView(selectedLosers: $selectedWinners, usersData: leagueData)
                            .padding()
                    } else {
                        Text("No users data available")
                    }

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
            if let leagues = leagueUserViewModel.leagueUserShow?.data {
                List(leagueUserViewModel.leagueUserShow?.data ?? [], id: \.id) { leagueUser in
                    Button(action: {
                        selectedLeagueIndex = leagueUser.league.id
                        leagueUserViewModel.getUsersInLeague(leagueId: selectedLeagueIndex ?? 0)
                        isLeagueSelectionPresented.toggle()
                    }) {
                        HStack {
                            Text(leagueUser.league.icon)
                            Text(leagueUser.league.name)
                        }
                    }
                }
                .navigationBarTitle("Sélectionner une ligue", displayMode: .inline)
            }
        }

        .sheet(isPresented: $isSummaryViewPresented) {
            if let selectedLeagueIndex = selectedLeagueIndex,
               let selectedLeagueName = leagueUserViewModel.leagueUserShow?.data?.first(where: { $0.league.id == selectedLeagueIndex })?.league.name {
                DuelSummaryView(selectedLeague: selectedLeagueName,
                                selectedWinners: selectedWinners,
                                selectedLosers: selectedLosers,
                                duelDescription: duelDescription)
            } else {
                Text("Sélectionnez une ligue")
            }
        }
        .onAppear {
            leagueUserViewModel.getLeagueUserShow()
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
