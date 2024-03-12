//
//  BattelListView.swift
//  Ranking
//
//  Created by Mathis Fleury on 05/11/2023.
//

import SwiftUI

struct DuelView: View {
    @StateObject private var duelViewModel = DuelViewModel()

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    HStack(alignment: .center) {
                        Image(systemName: "arrow.backward")
                            .frame(width: 35.0, height: 35.0)
                            .font(.system(size: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 999)
                                    .stroke(Color("PrimaryTextColor"), lineWidth: 1)
                            )
                        Spacer()
                        
                        Text("DUEL")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryTextColor"))
                        Spacer()
                        Image(systemName: "plus")
                            .frame(width: 35.0, height: 35.0)
                            .font(.system(size: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 999)
                                    .stroke(Color("PrimaryTextColor"), lineWidth: 1)
                            )
                    }
                    .padding(.all, 20.0)
                }
                .frame(height: 50.0)
                .background(
                    Image("pattern")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.top, 250.0)
                )

                VStack {
                    HStack() {
                        Text("Toute vos duels")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    if let duels = duelViewModel.responseDuelAll?.data {
                        ScrollView {
                            ForEach(duels, id: \.id) { item in
                                NavigationLink(destination: DetailDuelView(duelId: item.duelId)) {
                                    CardDuelView(leagueTitle: item.league.name, scoreElo: Double(item.leagueUserEloAdd), player1: item.user.name, player2: item.user.name)
                                }
                            }
                        }
                    } else {
                        // Consider adding a loading or empty state view here
                        Text("Loading...")
                    }
                    
                    Spacer()
                }
                .padding(.all, 20.0)
                .background(Color("PrimaryGray"))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
            }
        }
        .onAppear {
            duelViewModel.getAllDuel()
        }    }
    }

struct DuelView_Previews: PreviewProvider {
    static var previews: some View {
        DuelView()
    }
}
