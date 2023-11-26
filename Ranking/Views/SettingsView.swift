import SwiftUI

struct SettingsView: View {
    @State private var dashboardData: Dashboard?

    var body: some View {
        VStack {
            if let dashboard = dashboardData {
                // Si dashboardData contient des informations
                Text("Message : \(dashboard.message)")
                // Ajoutez ici plus de détails si dashboard contient d'autres informations
            } else {
                // Si dashboardData est nil, affichez un bouton pour charger les données
                Button("Charger les données du tableau de bord") {
                    fetchData()
                }
            }
        }
    }

    func fetchData() {
        Task {
            do {
                dashboardData = try await getDashboard()
                print(dashboardData?.leagueUserData)
            } catch {
                print("Erreur lors de la récupération des données du tableau de bord : \(error)")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
