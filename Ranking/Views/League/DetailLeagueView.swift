
import SwiftUI

struct DetailLeagueView: View {
    @StateObject private var leagueUserViewModel = LeagueUserViewModel()
    @StateObject private var leagueViewModel = LeagueViewModel()
    @State private var isAddLeagueUserPresented = false

    @Environment(\.presentationMode) var presentationMode
    let leagueTitle: String
    let leagueIcon: String
    let leagueId: Int

    init(leagueTitle: String, leagueIcon: String, leagueId: Int) {
        self.leagueTitle = leagueTitle
        self.leagueIcon = leagueIcon
        self.leagueId = leagueId
    }
    
    private func updateData() {
        leagueViewModel.getDetailLeagueSingel(leagueId: leagueId)
    }
    
    private func resetFields() {
        updateData()
        isAddLeagueUserPresented = false
    }

    var body: some View {
        VStack {
            ScrollView {
                if let leagueDetailSingle = leagueViewModel.leagueDetailSingel {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.backward")
                                .frame(width: 35.0, height: 35.0)
                                .font(.system(size: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 999)
                                        .stroke(Color("PrimaryTextColor"), lineWidth: 1)
                                )
                        }
                        Spacer()

                        Text(leagueDetailSingle.leagueData[0].icon)
                        Text(leagueDetailSingle.leagueData[0].name)
                        Spacer()
                        Button(action: {
                            // TODO: Implement action for plus button
                            isAddLeagueUserPresented.toggle()
                        }) {
                            Image(systemName: "plus")
                                .frame(width: 35.0, height: 35.0)
                                .font(.system(size: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 999)
                                        .stroke(Color("PrimaryTextColor"), lineWidth: 1)
                                )
                        }
                    }

                    Spacer().frame(height: 30)
                    BarChartView()

                    Spacer().frame(height: 30)
                    VStack {
                        HStack {
                            Text("Stats")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        Text("Pourcentage Victoires : \(leagueDetailSingle.globalStats.winRate)%")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("Nombre de match : \(leagueDetailSingle.globalStats.nbDuel)")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("Nombre de win : \(leagueDetailSingle.globalStats.nbWin)")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("Nombre de lose : \(leagueDetailSingle.globalStats.nbLose)")
                            .font(.title3)
                            .fontWeight(.bold)

                        HStack {
                            Text("Tous les joueurs")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }

                        ForEach(leagueDetailSingle.userLeagueData, id: \.id) { item in
                            CardPlayerView(scoreElo: Double(item.elo), player1: item.user.name, leagueId: item.league.id, userId: item.user.id, updateData: self.updateData)
                        }

                        Spacer().frame(height: 50)

                        HStack {
                            Text("Tous les duels")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }

                        ForEach(leagueDetailSingle.duelData, id: \.duel.id) { item in
                            NavigationLink(destination: DetailLeagueView(leagueTitle: item.duel.league.name, leagueIcon: item.duel.league.icon, leagueId: item.duel.league.id)) {
                                CardDuelView(leagueTitle: item.duel.league.name, scoreElo: Double(item.duel.leagueUserEloAdd), player1: item.duel.user.name, player2: item.duel.user.name)
                            }
                        }
                        Spacer()
                   
                        Button(action: { isAddLeagueUserPresented.toggle() }) {
                            Text("Ajouter un joueur dans la league")
                                .padding(.horizontal)
                        }
                        Spacer()
                        Button("Supprimer") {
                            leagueViewModel.deleteLeague(leagueId: leagueId)
                        }
                        Spacer()

                    }
                } else {
                    Text("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .sheet(isPresented: $isAddLeagueUserPresented) {
            // TODO: Present a view to add a new league
            AddLeagueUserView(isPresented: $isAddLeagueUserPresented, leagueId: leagueId)
        }
        .onChange(of: isAddLeagueUserPresented) { newValue in
                    if !newValue { // `isAddLeagueUserPresented` a été modifié pour être false, c'est-à-dire que la feuille a été fermée.
                        resetFields() // Ou tout autre logique que vous souhaitez exécuter.
                        // Par exemple, vous pouvez recharger les données ici si nécessaire.
                        leagueViewModel.getDetailLeagueSingel(leagueId: leagueId)
                    }
                }
        
        .padding(.all, 20)
        .background(Color("PrimaryGray"))
        .cornerRadius(20)
        .background(
            Image("pattern")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
        .background(Color("PrimaryGray"))
        .onAppear {
            leagueViewModel.getDetailLeagueSingel(leagueId: leagueId)
        }
        .navigationBarBackButtonHidden(true)
    }
}
