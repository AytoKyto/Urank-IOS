//
//  AuthMainNav.swift
//  Ranking
//
//  Created by Mathis Fleury on 31/12/2023.
//

import SwiftUI

struct AuthMainNav: View {
    @StateObject var authViewModel = AuthViewModel()

    
    var body: some View {
        NavigationView {
            VStack {
                Text("Bienvenue dans Ranking")
                    .font(.largeTitle)
                    .padding()

                Text("Rejoignez la communauté ou connectez-vous pour continuer.")
                    .font(.body)
                    .padding()

                NavigationLink(destination: SignUpView()) {
                    Text("Créer un compte")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()

                NavigationLink(destination: LoginView(authViewModel: authViewModel)) {
                    Text("Se connecter")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding()

                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct AuthMainNav_Previews: PreviewProvider {
    static var previews: some View {
        AuthMainNav()
    }
}
