//
//  DetailBattelView.swift
//  Ranking
//
//  Created by Mathis Fleury on 12/11/2023.
//

import SwiftUI

struct DetailDuelView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var duelViewModel = DuelViewModel()
    
    let duelId: Int

    init(duelId: Int) {
        self.duelId = duelId
    }

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            if let duelDetailSingle = duelViewModel.duelDetailSingel {
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

                    Text("DUEL")
                    Spacer()
                   
                }

                HStack {
                    Text(duelDetailSingle.duelUserMain.league.icon)
                    Text(duelDetailSingle.duelUserMain.league.name)
                }
                if ((duelViewModel.duelDetailSingel?.duel.description) != nil) {
                    HStack {
                        Text("Description : ")
                        Text(duelDetailSingle.duel.description ?? "")
                    }
                }
                HStack {
                    Text("Date du duel : ")
                    Text(duelDetailSingle.duel.createdAt)
                }
                HStack {
                    Text("coin : ")
                    Text("\(duelDetailSingle.duelUserMain.coin)")
                }
                HStack {
                    Text("Elo avant duel : ")
                    Text("\(duelDetailSingle.duelUserMain.leagueUserEloInit)")
                }
                HStack {
                    Text("Ajout elo : ")
                    Text("\(duelDetailSingle.duelUserMain.leagueUserEloAdd)")
                }
                HStack {
                    Text("Nombre de joueur : ")
                    Text("\(duelDetailSingle.nbrUsers)")
                }
                Spacer()
                Text("Winners : ")
                ForEach(duelDetailSingle.winners, id: \.id) { item in
                    HStack {
                        Text("Joueur : ")
                        Text("\(item.user.name)")
                    }
                }
                Spacer()
                Text("Losers : ")
                ForEach(duelDetailSingle.losers, id: \.id) { item in
                    HStack {
                        Text("Joueur : ")
                        Text("\(item.user.name)")
                    }
                }
                Spacer()
                
                
            } else {
                Text("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            duelViewModel.getDetailDuelSingel(duelId: duelId)
        }
        .navigationBarBackButtonHidden(true)
    }
}
