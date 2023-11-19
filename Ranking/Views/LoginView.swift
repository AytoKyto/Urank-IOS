//
//  LoginView.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/10/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggingIn = false // Vous pouvez utiliser cette variable pour gérer la connexion

    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)

                SecureField("Mot de passe", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                          
                Button(action: {
                    // Ajoutez ici le code pour gérer la connexion
                    // Par exemple, vérifier les identifiants, effectuer une requête HTTP, etc.
                    // Vous pouvez utiliser la variable `isLoggingIn` pour afficher un indicateur de chargement pendant la connexion.
                }) {
                    Text("Se connecter")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(isLoggingIn) // Empêcher les actions pendant la connexion

                Spacer()
            }
            .padding()
            .navigationBarTitle("Connexion")
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
