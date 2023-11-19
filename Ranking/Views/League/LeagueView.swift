//
//  LeagueView.swift
//  Ranking
//
//  Created by Mathis Fleury on 28/10/2023.
//

import SwiftUI

struct LeagueView: View {
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
                        
                        Text("LEAGUE")
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
                        Text("Toute vos leagues")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    ScrollView {
                        LeagueListView()
                        LeagueListView()
                        LeagueListView()
                        LeagueListView()
                        LeagueListView()
                        LeagueListView()
                        LeagueListView()
                        LeagueListView()
                        
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

struct LeagueView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueView()
    }
}
