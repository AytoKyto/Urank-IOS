//
//  LoginView.swift
//  Ranking
//
//  Created by Mathis Fleury on 27/10/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var authViewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isShowAlert = false

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

                Button("Login") {
                    authViewModel.login(request: LoginRequest(email: email, password: password)) { success in
                        if success {
                            // Naviguer vers la prochaine vue ou afficher le succès
                        } else {
                            isShowAlert = true
                        }
                    }
                }
                .disabled(email.isEmpty || password.isEmpty)
                .padding()

                Spacer()
            }
            .navigationBarTitle("Connexion")
            .alert(isPresented: $isShowAlert) {
                Alert(
                    title: Text("Erreur de connexion"),
                    message: Text("Vos informations d'identification sont incorrectes. Veuillez réessayer."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
