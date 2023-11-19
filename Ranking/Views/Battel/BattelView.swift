//
//  BattelListView.swift
//  Ranking
//
//  Created by Mathis Fleury on 05/11/2023.
//

import SwiftUI

struct BattelView: View {
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
                    ScrollView {
                        CardBattelView(leagueTitle: "Ping pong", scoreElo: 100, player1: "Mathis", player2: "Jeremy")
                    }
                    Spacer()
                }
                .padding(.all, 20.0)
                .background(Color("PrimaryGray"))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
            }
        }
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("PrimaryBlack")/*@END_MENU_TOKEN@*/)
    }
    }

struct BBattelView_Previews: PreviewProvider {
    static var previews: some View {
        BattelView()
    }
}
