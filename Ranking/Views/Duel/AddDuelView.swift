import SwiftUI

struct AddDuelView: View {
    @StateObject private var leagueUserViewModel = LeagueUserViewModel()
    @StateObject var duelViewModel = DuelViewModel()

    @State private var selectedLeagueIndex: Int?
    @State private var isLeagueSelectionPresented = false
    @State private var selectedWinners: Set<UserInLeagueIdElo> = []
    @State private var selectedLosers: Set<UserInLeagueIdElo> = []
    @State private var duelDescription = ""
    @State private var isSummaryViewPresented = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private func resetFields() {
            selectedLeagueIndex = nil
            isLeagueSelectionPresented = false
            selectedWinners = []
            selectedLosers = []
            duelDescription = ""
            isSummaryViewPresented = false
            showAlert = false
        }

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
                if leagueUserViewModel.leagueUserShow != nil {
                               // Afficher les données de leagueUserShow
                           } else if leagueUserViewModel.isError {
                               Text("Une erreur est survenue.")
                           } else {
                               Text("Chargement...")
                           }
                
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

                Text("Select Winners")
                    .font(.title3)

                if selectedLeagueIndex != nil {
                    if let leagueData = leagueUserViewModel.usersInLeague?.data {
                        UsersSelectionView(selectedUsers: $selectedWinners, usersData: leagueData)
                            .padding()
                    } else {
                        Text("No users data available")
                    }
                    
                    Text("Select Loser")
                        .font(.title3)

                    if let leagueData = leagueUserViewModel.usersInLeague?.data {
                        UsersSelectionView(selectedUsers: $selectedLosers, usersData: leagueData)
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
                    Button("Reset") {
                                       resetFields()
                                   }
                                   .padding()
                                   .background(Color.red)
                                   .foregroundColor(.white)
                                   .cornerRadius(10)

                    Button("Valider") {
                        if let selectedLeague = leagueUserViewModel.leagueUserShow?.data.first(where: { $0.league.id == selectedLeagueIndex }) {
                                    let request = DuelRequest(
                                        leagueId: selectedLeague.league.id,
                                        isNull: false,
                                        description: duelDescription,
                                        winUser: Array(selectedWinners),
                                        loseUser: Array(selectedLosers)
                                    )
                                    duelViewModel.duelAdd(request: request) { success in
                                        if success {
                                            resetFields()

                                            alertMessage = "Success message here"
                                        } else {
                                            alertMessage = "Error message here"
                                        }
                                        showAlert = true
                                    }
                                } else {
                                    alertMessage = "Selected league is nil."
                                    showAlert = true
                                }
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text(alertMessage))
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
            if (leagueUserViewModel.leagueUserShow?.data) != nil {
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
               let leagues = leagueUserViewModel.leagueUserShow?.data,
               let selectedLeague = leagues.first(where: { $0.league.id == selectedLeagueIndex }) {
                
                DuelSummaryView(selectedLeague: "\(selectedLeague.league.icon) \(selectedLeague.league.name)",
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

struct AddDuelView_Previews: PreviewProvider {
    static var previews: some View {
        AddDuelView()
    }
}
