//
//  RegisterView.swift
//  MaintenanceReminder
//
//  Created by YASSINE on 5/7/2023.
//

import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var message = ""
    @State private var showError = false
    @State private var loggedIn = false
    @ObservedObject var registerViewModel  = RegisterViewModel()
    var body: some View {
        NavigationStack{
            ZStack(alignment: .topLeading){
                VStack{
                    VStack(spacing: 40){
                        Spacer()
                        Spacer()
                            Text("S'inscrire")
                                .foregroundColor(Color("skyBlue"))
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                        VStack{
                            VStack{
                                CustomTextField(password: false, placeHolder: "Prénom", imageName: "person", bColor: "primaryTextColor", tOpacity: 0.6, value: $username)
                                CustomTextField(password: false, placeHolder: "Email", imageName: "envelope", bColor: "primaryTextColor", tOpacity: 0.6, value: $email)
                                CustomTextField(password: true, placeHolder: "Mot de passe", imageName: "lock", bColor: "primaryTextColor", tOpacity: 0.6, value: $password)
                                CustomTextField(password: true, placeHolder: "Confirmer le mot de passe", imageName: "lock", bColor: "primaryTextColor", tOpacity: 0.6, value: $confirmPassword)
                                
                                
                                    Button (action: {                                    
                                        Task {
                                            await registerViewModel.registerUser(username: username, email: email, password: password, confirmPassword: confirmPassword)
                                            if registerViewModel.isLoggedIn {
                                                loggedIn = true
                                                showError = false
                                            }
                                            if registerViewModel.showError {
                                                loggedIn = false
                                                showError = true
                                            }
                                        }
                                    }, label: {
                                        CustomButton(title: "S'inscrire", bgColor: "skyBlue", labelColor: "white")
                                    })
                                    .padding()
    
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        
                        Text("Vous avez déjà un compte ? ")
                            .foregroundColor(Color("primaryTextColor"))
                            .font(.system(size: 18))
                        NavigationLink(destination: LoginView()){
                                Text("Se connecter")
                                    .bold()
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("skyBlue"))
                        }
                    }
                    .frame(height: 63)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .overlay(
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundColor(Color("primaryTextColor").opacity(0.6))
                            .padding(.top, -20)
                    )
                    
                    
                }
                NavigationLink(destination: HomeView()){
                    BackButtonView()
                        .padding(.top, 50)
                }
            }
            .ignoresSafeArea()
            .alert(isPresented: $showError) {
                Alert(title: Text("Erreur !"), message: Text(registerViewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }.navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $loggedIn) {
                CloseRemindersView()
            }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
