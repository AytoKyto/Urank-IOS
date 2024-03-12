//
//  LeagueView.swift
//  Ranking
//
//  Created by Mathis Fleury on 28/10/2023.
//

import SwiftUI

struct LeagueView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject private var leagueUserViewModel = LeagueUserViewModel()
    @State private var isAddLeaguePresented = false

    private func resetFields() {
        isAddLeaguePresented = false
        leagueUserViewModel.getLeagueUserShow()
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Navigation header
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

                        Text("LEAGUE")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryTextColor"))
                        Spacer()

                        Button(action: {
                            // TODO: Implement action for plus button
                            isAddLeaguePresented.toggle()
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
                    .padding(.all, 20.0)
                    .frame(height: 50.0)
                    .background(
                        Image("pattern")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.top, 250.0)
                    )

                    VStack {
                        HStack {
                            Text("Toutes vos leagues")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }

                        if let leagues = leagueUserViewModel.leagueUserShow?.data {
                            ScrollView {
                                ForEach(leagues, id: \.id) { item in
                                    NavigationLink(destination: DetailLeagueView(leagueTitle: item.league.name, leagueIcon: item.league.icon, leagueId: item.league.id)) {
                                        CardLeagueView(title: item.league.name, icon: item.league.icon, eloPlayer: Double(item.elo), eloBestPlayer: Double(item.elo))
                                    }
                                }
                            }
                        } else {
                            // Loading or empty state view
                            Text("Loading...")
                        }

                        Spacer()
                    }
                    .padding(.all, 20.0)
                    .background(Color("PrimaryGray"))
                    .cornerRadius(20.0)
                }
            }
            .onAppear {
                leagueUserViewModel.getLeagueUserShow()
            }
            .sheet(isPresented: $isAddLeaguePresented) {
                // TODO: Present a view to add a new league
                AddLeagueView(isPresented: $isAddLeaguePresented)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
