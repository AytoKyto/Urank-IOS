//
//  RoundedBoxView.swift
//  Ranking
//
//  Created by Mathis Fleury on 18/11/2023.
//

import SwiftUI

struct RoundedBox<Content>: View where Content: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        HStack() {
            content
        }
        .padding(.all, 10.0)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("PrimaryGray"), lineWidth: 1.5)
        )
        .padding(15.0)
    }
}

struct RoundedBox_Previews: PreviewProvider {
    static var previews: some View {
        RoundedBox {
            Text("This is a Rounded Box")
        }
        .padding()
    }
}
