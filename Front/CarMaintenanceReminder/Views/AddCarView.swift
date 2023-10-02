//
//  AddCarView.swift
//  MaintenanceReminder
//
//  Created by YASSINE on 8/7/2023.
//

import SwiftUI

struct AddCarView: View {
    @State private var brand : String = ""
    @State private var model : String = ""
    @State private var libelle : String = ""
        
    @State private var showError : Bool = false
    @State private var sucess : Bool = false
    @State var notAuthenticated = false
    
    @ObservedObject var carDataModel = CarDataModel()
    @ObservedObject var userModel = UserNameModel()
    
    
    var body: some View {
        NavigationStack {
            ScrollView{
                ZStack{
                    VStack(alignment : .leading){
                        Ellipse()
                            .foregroundColor(Color("skyBlue"))
                            .frame(width: 800, height: 500)
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                            .position(x: UIScreen.main.bounds.width / 2, y: -100)
                    }.frame( maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    VStack(alignment : .leading){
                        HStack(alignment : .center){
                            NavigationLink(destination: CarsView()) {
                                RoundedSmallButtonView(image: "arrow.backward", bgColor: "white", iconColor: "skyBlue").padding()
                            }
                            Spacer()
                            Text("Ajouter une Voiture ")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .multilineTextAlignment(.center)
                            Spacer()
                            
                                Button (action: {
                                    Task{
                                        await carDataModel.addCar(brand: brand, model: model, libelle: libelle)
                                        if carDataModel.showError {
                                            self.showError = true
                                        }else{
                                            self.sucess = true
                                        }
                                    }
                                    
                                }, label: {
                                    RoundedSmallButtonView(image: "plus", bgColor: "white", iconColor: "skyBlue").padding()
                                })
                        
                        }
                    }.frame(maxWidth: .infinity)
                        .position(x: UIScreen.main.bounds.width / 2, y: 50)
                    Spacer()
                    VStack{
                        CustomTextField(password: false, placeHolder: "Marque", imageName: "car.fill", bColor: "primaryTextColor", tOpacity: 0.6, value: $brand)
                        CustomTextField(password: false, placeHolder: "Modèle", imageName: "car.side.fill", bColor: "primaryTextColor", tOpacity: 0.6, value: $model)
                        CustomTextField(password: false, placeHolder: "Libellé", imageName: "menucard", bColor: "primaryTextColor", tOpacity: 0.6, value: $libelle)
                    }.frame(maxHeight: .infinity)
                        .padding(.top, 180)
                    Spacer()
                }
            }.alert(isPresented: $showError) {
                Alert(title: Text("Erreur !"), message: Text(carDataModel.errorMessage), dismissButton: .default(Text("OK")))
            }.navigationDestination(isPresented: $sucess) {
                CarsView()
            }.navigationDestination(isPresented: $notAuthenticated) {
                HomeView()
            }
        }.navigationBarBackButtonHidden(true)
            .onAppear{
                Task{
                    await userModel.verify()
                    if !userModel.isAuthenticated {
                        notAuthenticated = true
                    }
                }
            }
    }
}

struct AddCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCarView()
    }
}
