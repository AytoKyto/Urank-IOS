import SwiftUI

struct DashboardView: View {
    @State private var highValue = "2000"
    @ObservedObject var authManager = AuthManager()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack() {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "person")
                                    .foregroundColor(Color("PrimaryTextColor"))
                                    .frame(width: 40.0, height: 40.0)
                                    .font(.system(size: 20))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 999)
                                            .stroke(Color("PrimaryTextColor"), lineWidth: 1)
                                    )
                            }
                            Spacer()

                        }
                        .padding(.all, 20.0)
                        
                        Button("Login") {
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
                                Text(highValue)
                                    .font(.largeTitle)
                                    .fontWeight(.black)
                                    .foregroundColor(Color("PrimaryTextColor"))
                                    .padding(1.0)
                                
                                Text("🏓 Ping pong #1")
                                    .font(.subheadline)
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
                        VStack() {
                            HStack() {
                                Text("Vos ligues")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("PrimaryTextColor"))
                                Spacer()
                            }
                            .padding(.top, 10.0)
                            .padding(.leading, 5.0)

                            
                            VStack() {
                                HStack() {
                                    NavigationLink(destination: DetailLeagueView()) {
                                        CardLeagueView(title: "LA Ping pong", icon: "🏀", eloPlayer: 1000, eloBestPlayer: 2000)
                                    }
                                    
                                    NavigationLink(destination: DetailLeagueView()) {
                                        CardLeagueView(title: "LA Ping pong", icon: "🏀", eloPlayer: 1000, eloBestPlayer: 2000)
                                    }
                                }
                                
                                HStack() {
                                    CardLeagueView(title: "LA Ping pong", icon: "🏀", eloPlayer: 1000, eloBestPlayer: 2000)
                                    CardLeagueView(title: "LA Ping pong", icon: "🏀", eloPlayer: 2000, eloBestPlayer: 2000)
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
                        VStack() {
                            HStack() {
                                Text("Vos dernier duels")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("PrimaryTextColor"))
                                Spacer()
                            }
                            .padding(.top, 10.0)
                            .padding(.leading, 5.0)

                            
                            VStack() {
                                NavigationLink(destination: DetailLeagueView()) {
                                    CardBattelView(leagueTitle: "Ping pong", scoreElo: 100, player1: "Mathis", player2: "Jeremy")
                                }
                                NavigationLink(destination: DetailLeagueView()) {
                                    CardBattelView(leagueTitle: "Ping pong", scoreElo: 100, player1: "Mathis", player2: "Jeremy")
                                }
                                NavigationLink(destination: DetailLeagueView()) {
                                    CardBattelView(leagueTitle: "Ping pong", scoreElo: 100, player1: "Mathis", player2: "Jeremy")
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
