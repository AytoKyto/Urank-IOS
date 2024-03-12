import SwiftUI

struct DashboardView: View {
    @State private var highValue = "2000"
    @ObservedObject var authManager = AuthManager()
    @StateObject private var dashboardViewModel = DashboardViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Button("Logout") {
                            authManager.clearAccessToken()
                        }

                        Spacer()
                            .frame(height: 10.0)

                        VStack(alignment: .leading) {
                            Text("Votre meilleur classement")
                                .font(.title2)
                                .fontWeight(.black)
                                .foregroundColor(Color("PrimaryTextColor"))
                                .multilineTextAlignment(.leading)

                            HStack {
                                Text("\(dashboardViewModel.responseDashboard?.league[0].duel.elo ?? 0)")
                                    .font(.largeTitle)
                                    .fontWeight(.black)
                                    .foregroundColor(Color("PrimaryTextColor"))
                                    .padding(1.0)

                                HStack {
                                    Text(dashboardViewModel.responseDashboard?.league[0].duel.league.icon ?? "")
                                    Text(dashboardViewModel.responseDashboard?.league[0].duel.league.name ?? "")

                                }.font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("PrimaryTextColor"))
                            }
                        }
                        .padding(.horizontal, 20.0)

                    }.background(
                        Image("pattern")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.top, 220.0)
                    )

                    Spacer()
                        .frame(width: 100.0, height: /*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)

                    RoundedBox {
                        VStack {
                            HStack {
                                Text("Vos ligues")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("PrimaryTextColor"))
                                Spacer()
                            }
                            .padding(.top, 10.0)
                            .padding(.leading, 5.0)

                            VStack {
                                if let leagues = dashboardViewModel.responseDashboard?.league {
                                    ForEach(leagues, id: \.duel.id) { item in
                                        NavigationLink(destination: DetailLeagueView(leagueTitle: item.duel.league.name, leagueIcon: item.duel.league.icon, leagueId: item.duel.league.id)) {
                                            CardLeagueView(title: item.duel.league.name, icon: item.duel.league.icon, eloPlayer: Double(item.duel.elo), eloBestPlayer: Double(item.duel.elo))
                                        }
                                    }
                                } else {
                                    Text("Pas de données")
                                }
                            }

                            NavigationLink {
                                LeagueView()
                            }
                        label: {
                                Text("Voir plus")
                            }
                            .frame(maxWidth: .infinity, maxHeight: 5)
                            .padding()
                            .foregroundColor(Color("PrimaryTextColor"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("PrimaryGray"), lineWidth: 1)
                            )
                        }
                    }

                    RoundedBox {
                        VStack {
                            HStack {
                                Text("Vos dernier duels")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("PrimaryTextColor"))
                                Spacer()
                            }
                            .padding(.top, 10.0)
                            .padding(.leading, 5.0)

                            VStack {
                                if let duels = dashboardViewModel.responseDashboard?.duelData {
                                    ForEach(duels, id: \.duel.id) { item in
                                        NavigationLink(destination: DetailDuelView(duelId: item.duel.duelId)) {
                                            CardDuelView(leagueTitle: item.duel.league.name, scoreElo: Double(item.duel.leagueUserEloAdd), player1: item.duel.user.name, player2: item.duel.user.name)
                                        }
                                    }
                                } else {
                                    Text("Pas de données")
                                }
                            }

                            NavigationLink {
                                DuelView()
                            }
                        label: {
                                Text("Voir plus")
                            }
                            .frame(maxWidth: .infinity, maxHeight: 5)
                            .padding()
                            .foregroundColor(Color("PrimaryTextColor"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("PrimaryGray"), lineWidth: 1)
                            )
                        }
                        .onAppear {
                            dashboardViewModel.getDashboardData()
                        }
                    }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
