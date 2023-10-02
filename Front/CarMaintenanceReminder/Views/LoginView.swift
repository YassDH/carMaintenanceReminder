//
//  LoginView.swift
//  MaintenanceReminder
//
//  Created by YASSINE on 5/7/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var loggedIn = false
    @ObservedObject var loginViewModel  = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .topLeading){
                VStack{
                    VStack(spacing: 40){
                        Spacer()
                            Text("Se connecter")
                                .foregroundColor(Color("skyBlue"))
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                        VStack{
                            VStack{
                                CustomTextField(password: false, placeHolder: "Email", imageName: "person", bColor: "primaryTextColor", tOpacity: 0.6, value: $email).autocapitalization(.none)
                                CustomTextField(password: true, placeHolder: "Mot de passe", imageName: "lock", bColor: "primaryTextColor", tOpacity: 0.6, value: $password).autocapitalization(.none)
                                
                                    Button (action: {
                                        Task {                                          
                                            await loginViewModel.loginUser(email: email, password: password)
                                            if loginViewModel.isLoggedIn {
                                                loggedIn = true
                                                showError = false
                                            }
                                            if loginViewModel.showError {
                                                loggedIn = false
                                                showError = true
                                            }
                                        } 
                                    }, label: {
                                        CustomButton(title: "Se connecter", bgColor: "skyBlue", labelColor: "white")
                                    })
                                    .padding()
    
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        
                        Text("Vous n'avez pas de compte ? ")
                            .foregroundColor(Color("primaryTextColor"))
                            .font(.system(size: 18))
                        NavigationLink(destination: RegisterView()){
                                Text("S'inscrire")
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
                Alert(title: Text("Erreur !"), message: Text(loginViewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }.navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $loggedIn) {
            CloseRemindersView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
