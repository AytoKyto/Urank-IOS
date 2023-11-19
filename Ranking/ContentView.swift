//
//  ContentView.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink("Go to Settings", destination: SetingsView())
        }
    }
}

struct SetingsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            NavigationLink("Test") {
                Text("Detail View")
                    .navigationTitle("Detail Title")
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                // Action personnalisée du bouton de retour
                                dismiss()
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.backward")
                                    Text("Custom Backk")
                                }
                            }
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
