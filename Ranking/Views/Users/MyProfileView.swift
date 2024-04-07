import SwiftUI

struct MyProfileView: View {
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                if let myProfile = userViewModel.myProfile {
                    // Assume `myProfile` is a non-optional property.
                    // The UI elements are now refactored into their own computed properties.
                    headerView(myProfile: myProfile)
                    profileSection(myProfile: myProfile)
                    personalizeButton
                    premiumOfferSection
                    itemList
                } else {
                    Text("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .navigationTitle("Ton Profil")
        .navigationBarItems(leading: backButton)
        .onAppear {
            userViewModel.getDetailLeague()
        }
    }

    private func headerView(myProfile: MyProfileServerResponse) -> some View {
        HStack {
            Image(systemName: "arrow.left")
            Spacer()
            Text("\(myProfile.user.coins)")
                .font(.title)
            Image("coin") // Make sure to add the coin image in your assets
        }
        .padding()
    }

    private func profileSection(myProfile: MyProfileServerResponse) -> some View {
        VStack {
            Image("profileImage") // Add the profile image in your assets
                .clipShape(Circle())
            Text(myProfile.user.name)
                .font(.title)
            HStack {
                StatisticView(icon: "r.circle", value: "\(myProfile.userStats.winRate)%")
                StatisticView(icon: "w.circle", value: "\(myProfile.userStats.nbWin)")
                StatisticView(icon: "l.circle", value: "\(myProfile.userStats.nbLose)")
            }
        }
        .padding()
        .background(Color.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }

    private var personalizeButton: some View {
        Button("PERSONNALISER") {
            // Handle personalization action
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }

    private var premiumOfferSection: some View {
        VStack {
            Text("Obtenir la version Premium")
                .font(.headline)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit...")
                .font(.subheadline)
            Button("Commencez votre essai gratuit") {
                // Handle start trial action
            }
            .buttonStyle(.bordered)
            Button("Restaurer l'achat") {
                // Handle restore purchase action
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .background(Color.orange)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }

    private var itemList: some View {
        ForEach(0..<4) { _ in
            HStack {
                Text("Title")
                Spacer()
                Text("Detail")
                Image(systemName: "chevron.right")
            }
            .padding()
        }
    }

    private var backButton: some View {
        Button(action: {
            // Implement your navigation back action here
        }) {
            Image(systemName: "chevron.left")
        }
    }
}

struct StatisticView: View {
    let icon: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(value)
        }
    }
}
