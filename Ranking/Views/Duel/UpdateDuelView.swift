//
//  DetailBattelView.swift
//  Ranking
//
//  Created by Mathis Fleury on 12/11/2023.
//

import SwiftUI

struct UpdateDuelView: View {
    @State private var selectedLeague = 0
    @State private var selectedWinner = 0
    @State private var selectedLoser = 0
    @State private var duelDescription = ""
    
    let leagues = ["League A", "League B", "League C"]
    let players = ["Player 1", "Player 2", "Player 3"]
    
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
                    Form {
                        Section(header: Text("Duel Information")) {
                            Picker("Select League", selection: $selectedLeague) {
                                ForEach(0..<leagues.count) { index in
                                    Text(leagues[index]).tag(index)
                                }
                            }
                            
                            Picker("Select Winner", selection: $selectedWinner) {
                                ForEach(0..<players.count) { index in
                                    Text(players[index]).tag(index)
                                }
                            }
                            
                            Picker("Select Loser", selection: $selectedLoser) {
                                ForEach(0..<players.count) { index in
                                    Text(players[index]).tag(index)
                                }
                            }
                            
                            TextField("Duel Description", text: $duelDescription)
                        }
                        
                        Section {
                            Button("Add Duel") {
                                // Handle adding the duel to your data or perform the desired action here
                            }
                        }
                    }
                    .navigationBarTitle("Add Duel", displayMode: .inline)
                }
            }
        }
    }

struct UpdateDuelView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDuelView()
    }
}
