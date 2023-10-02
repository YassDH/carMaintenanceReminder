//
//  AddReminderView.swift
//  MaintenanceReminder
//
//  Created by YASSINE on 10/7/2023.
//

import SwiftUI

struct AddReminderView: View {
    var carId : Int = 1
    
    @State private var name : String = ""
    @State private var distance : Int = 0
    @State private var maintDate : Date = Date()
    @State private var price : Double = 0
    @State private var distancePeriod = 0
    @State private var datePeriod = 0
    
    @State private var message : String = ""
    @State private var showError : Bool = false
    @State private var sucess : Bool = false
    @State var notAuthenticated = false
    
    @ObservedObject var remindersDataModel = RemindersDataModel()
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
                            Text("Ajouter un Rappel ")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .multilineTextAlignment(.center)
                            Spacer()
                                Button (action: {
                                    showError=false
                                    sucess = false
                                    Task{
                                        await remindersDataModel.addReminder(carID: carId, name: name, beginDate: maintDate, distance: distance, timePeriodicity: datePeriod, distancePeriodicity: distancePeriod, price: price)
                                        if remindersDataModel.showError {
                                            showError=true
                                            sucess=false
                                        }else{
                                            showError=false
                                            sucess = true
                                            name=""
                                            distance = 0
                                            price = 0
                                            distancePeriod = 0
                                            datePeriod = 0
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
                        Text("Informations Générales :")
                            .frame(maxWidth: .infinity ,alignment: .leading)
                            .padding(.horizontal)
                            .foregroundColor(Color("skyBlue"))
                            .bold()
                        CustomTextField(password: false, placeHolder: "Nom du Rappel", imageName: "pencil", bColor: "primaryTextColor", tOpacity: 0.6, value: $name)
                        CustomNumberField(placeHolder: "Kilométrage", imageName: "road.lanes.curved.left", bColor: "primaryTextColor", tOpacity: 0.6, value: $distance)
                        CustomDatePicker(textContent: "Date", value: $maintDate)
                        CustomPriceField(placeHolder: "Montant", imageName: "dollarsign", bColor: "primaryTextColor", tOpacity: 0.6, value: $price)
                        
                        Text("Périodicité:")
                            .frame(maxWidth: .infinity ,alignment: .leading)
                            .padding(.horizontal)
                            .foregroundColor(Color("skyBlue"))
                            .bold()
                        ToggleNumberField(placeholder: "Kilomètres",icon: "road.lanes.curved.left", inputValue: $distancePeriod)
                        ToggleNumberField(placeholder: "Mois",icon: "calendar", inputValue: $datePeriod)
                    }.frame(maxHeight: .infinity)
                        .padding(.top, 180)
                    Spacer()
                }
            }.alert(isPresented: $showError) {
                Alert(title: Text("Erreur !"), message: Text(remindersDataModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }.navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $notAuthenticated) {
                HomeView()
            }
            .onAppear{
                Task{
                    await userModel.verify()
                    if !userModel.isAuthenticated {
                        notAuthenticated = true
                    }
                }
            }
            .navigationDestination(isPresented: $sucess) {
                CarsView()
            }
            
            
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView()
    }
}
