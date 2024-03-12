//
//  ProfilView.swift
//  Ranking
//
//  Created by Mathis Fleury on 07/04/2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack {
                // Header
                headerView
                // Profile Section
                profileSection
                // Personalize Button
                personalizeButton
                // Premium Offer Section
                premiumOfferSection
                // List of Items
                itemList
            }
        }
        .navigationTitle("Ton Profil")
        .navigationBarItems(leading: backButton)
    }

    var headerView: some View {
        HStack {
            Image(systemName: "arrow.left")
            Spacer()
            Text("3910")
                .font(.title)
            Image("coin") // Make sure to add the coin image in your assets
        }
        .padding()
    }

    var profileSection: some View {
        VStack {
            Image("profileImage") // Add the profile image in your assets
                .clipShape(Circle())
            Text("John Doe")
                .font(.title)
            HStack {
                StatisticView(icon: "w.circle", value: "50.3%")
                StatisticView(icon: "c.circle", value: "1039")
                StatisticView(icon: "star.circle", value: "523")
            }
        }
        .padding()
        .background(Color.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }

    var personalizeButton: some View {
        Button("PERSONNALISER") {
            // Handle personalization action
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }

    var premiumOfferSection: some View {
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

    var itemList: some View {
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

    var backButton: some View {
        Button(action: {
            // Handle back action
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
