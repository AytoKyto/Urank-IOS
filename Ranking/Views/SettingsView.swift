//
//  SettingsView.swift
//  Ranking
//
//  Created by Mathis Fleury on 28/10/2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            NavigationLink("Test") {
                Text("Add")
                           .navigationTitle("Detail Title")
                           .navigationBarBackButtonHidden(true)
                           .toolbar {
                               ToolbarItem(placement: .navigationBarLeading) {
                                   Button(action: {
                                       // Action personnalisée
                                   }) {
                                       HStack {
                                           Image(systemName: "arrow.backward")
                                           Text("Custom Back")
                                       }
                                   }
                               }
                           }
                           
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

