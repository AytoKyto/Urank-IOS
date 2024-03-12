//
//  AddLeagueView.swift
//  Ranking
//
//  Created by Mathis Fleury on 14/03/2024.
//

import SwiftUI

struct AddLeagueView: View {
    @StateObject private var leagueViewModel = LeagueViewModel()
    @Binding var isPresented: Bool
    @State private var leagueTitle: String = ""
    @State private var leagueIconName: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    private func resetFields() {
        leagueTitle = ""
        leagueIconName = ""
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("League Details")) {
                    TextField("League Title", text: $leagueTitle)
                    TextField("Icon Name (SF Symbols)", text: $leagueIconName)
                }
                
                Section {
                    Button("Add League") {
                        let request = LeagueRequest(icon: leagueIconName, name: leagueTitle)
                        leagueViewModel.leagueAdd(request: request) { success in
                            if success {
                                resetFields()
                                isPresented = false
                                alertMessage = "League successfully added!"
                            } else {
                                alertMessage = "Failed to add the league. Please try again."
                            }
                            showAlert = true
                        }
                    }
                    .disabled(leagueTitle.isEmpty || leagueIconName.isEmpty)
                }
            }
            .navigationTitle("Add League")
            .navigationBarItems(trailing: Button("Cancel") { isPresented = false })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Add League"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}
