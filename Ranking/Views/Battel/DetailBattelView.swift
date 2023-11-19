//
//  DetailBattelView.swift
//  Ranking
//
//  Created by Mathis Fleury on 12/11/2023.
//

import SwiftUI

struct DetailBattelView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        // Title
                        Text("DUEL")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryTextColor"))
                        
                        Spacer()
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
            }
        }
    }
}

struct DetailBattelView_Previews: PreviewProvider {
    static var previews: some View {
        DetailBattelView()
    }
}
