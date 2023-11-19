import SwiftUI

struct DetailLeagueView: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        VStack {
         
            Spacer().frame(height: 30.0)
            BarChartView()

            Spacer().frame(height: 30.0)
            VStack {
                ScrollView {
                HStack {
                    Text("Tout les joueurs")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                    CardPlayerView(scoreElo: 100, player1: "Mathis")
                Spacer()
                        .frame(height: 50.0)
                HStack {
                    Text("Tout les duels")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                    CardBattelView(leagueTitle: "Ping pong", scoreElo: 100, player1: "Mathis", player2: "Jeremy")
                Spacer()
                }
            }
            .padding(.all, 20.0)
            .background(Color("PrimaryGray"))
            .cornerRadius(20.0)
            
        }
        .background(
            Image("pattern")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
        .background(Color("PrimaryGray"))
        .navigationTitle("🏀 Nba")
        }
    }

struct DetailLeagueView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLeagueView()
    }
}
