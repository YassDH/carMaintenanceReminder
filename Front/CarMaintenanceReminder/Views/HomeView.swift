//
//  HomeView.swift
//  MaintenanceReminder
//
//  Created by YASSINE on 5/7/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.cyan , .blue], startPoint: .topTrailing, endPoint: .bottomLeading)
                VStack{
                    Spacer()
                    //APP LOGO
                    HStack(spacing: 0.0){
                        Image(systemName: "gearshape")
                            .font(.system(size: 55))
                        VStack(alignment: .leading, spacing: -5.0){
                            Text("My Car")
                                .font(.system(size: 45))
                                .multilineTextAlignment(.leading)
                                .bold()
                            Text("Maintenance Reminder")
                                .font(.system(size: 20))
                                .multilineTextAlignment(.leading)
                                .fontWeight(.light)
                        }
                    }
                    .foregroundColor(Color.white)
                    Spacer()
                    //LOGIN AND SIGN UP BUTTONS
                    NavigationLink(destination: LoginView()){
                        CustomButton(title: "Se connecter", bgColor: "white" , labelColor: "skyBlue")
                            .padding(.bottom, 10.0)
                    }
                    NavigationLink(destination: RegisterView()){
                        CustomButton(title: "S'inscrire", bgColor: "white", labelColor: "skyBlue")
                    }
                    Spacer()
                    
                    //FOOTER
                    Text("Maintenance Reminder App v1.0")
                        .foregroundColor(.white)
                        .fontWeight(.thin)
                }
                .padding()
            }
            .ignoresSafeArea()
        }.navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
