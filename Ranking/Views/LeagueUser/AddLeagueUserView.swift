import SwiftUI

struct AddLeagueUserView: View {
    @StateObject private var invitationsUserViewModel = InvitationsUserViewModel()
    @StateObject private var leagueUserViewModel = LeagueUserViewModel()
    

    @Binding var isPresented: Bool
    @State private var userInput: String = ""
    var leagueId: Int
    @State private var selectedUsers: Set<Int> = []
    @State private var isSelectTypeUser: Bool = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
        
    var body: some View {
        NavigationView {
            VStack {
                userSelectionButtons
                
                if isSelectTypeUser {
                    userTextField(placeholder: "Entrez l'identifiant utilisateur")
                } else {
                    userTextField(placeholder: "Entrez le nom de l'utilisateur à inviter")
                }

                Spacer()

                if let invitationsUserData = invitationsUserViewModel.responseInvitationsUser {
                    invitedUsersList(invitationsUserData: invitationsUserData)
                } else {
                    loadingView
                }
            }
            .navigationBarItems(
                leading: Button("Annuler") { isPresented = false },
                trailing: Button("Valider") { isPresented = false }
            )
            .navigationBarTitle("Ajouter des utilisateurs", displayMode: .inline)
            .onAppear(perform: invitationsUserViewModel.getAllInvitationsUser)
        }
    }

    @ViewBuilder
    private var userSelectionButtons: some View {
        HStack {
            Button(action: { isSelectTypeUser = true }) {
                Text("Utilisateur existant")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            Button(action: { isSelectTypeUser = false }) {
                Text("Utilisateur à inviter")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    @ViewBuilder
    private func userTextField(placeholder: String) -> some View {
        TextField(placeholder, text: $userInput)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }

    @ViewBuilder
    private func invitedUsersList(invitationsUserData: ServerResponseInvitationsUser) -> some View {
        Text("Utilisateur déjà invité")
        ScrollView {
            ForEach(invitationsUserData.data, id: \.user.id) { invitation in
                let user = invitation.user
                MultipleSelectionRow(title: user.name, isSelected: selectedUsers.contains(user.id)) {
                    if selectedUsers.contains(user.id) {
                        selectedUsers.remove(user.id)
                    } else {
                        selectedUsers.insert(user.id)
                    }
                }
            }
        }
        .frame(minHeight: 0, maxHeight: 350)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding()
        
        Button(action: addUser) {
            Text("Ajouter")
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
        }
        .padding()
    }

    @ViewBuilder
    private var loadingView: some View {
        Text("Chargement...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .padding()
    }

    private func addUser() {
        // Early exit if userInput is empty or no users are selected
        guard !userInput.isEmpty || selectedUsers != [] else {
            print("User input is empty or no users are selected.")
            print(userInput)
            print(!userInput.isEmpty)

            print(selectedUsers)
            print(selectedUsers != [])


            return
        }

        let request = UserInLeagueRequest(usersId: Array(selectedUsers), userGuest: userInput, userAdd: 0, leagueId: leagueId)
        print(request)

        leagueUserViewModel.addUsersInLeague(request: request) { success in
            if success {
                DispatchQueue.main.async {
                    self.isPresented = false
                    self.alertMessage = "League successfully added!"
                }
                print("League successfully added!")
            } else {
                DispatchQueue.main.async {
                    self.alertMessage = "Failed to add the league. Please try again."
                }
                print("Failed to add the league. Please try again.")
            }
            DispatchQueue.main.async {
                self.showAlert = true
            }
        }
    }

}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
        .background(Color.white)
        .cornerRadius(8)
        .padding(.vertical, 4)
    }
}

