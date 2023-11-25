import SwiftUI

struct SettingsView: View {
    @State private var users: [User] = [] // Maintenant un tableau de User

    var body: some View {
        VStack {
            if users.isEmpty {
                Button("Charger les utilisateurs") {
                    fetchData()
                }
            } else {
                // Affichez les informations de tous les utilisateurs ou du premier utilisateur
                ForEach(users, id: \.id) { user in
                    Text("Nom d'utilisateur : \(user.name)")
                    // Affichez d'autres informations utilisateur si nécessaire
                }
            }
        }
    }

    func fetchData() {
        Task {
            do {
                users = try await getUser() // getUsers renvoie maintenant un tableau de User
            } catch {
                print("Erreur lors de la récupération des utilisateurs : \(error)")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
