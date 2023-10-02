//
//  CarsView.swift
//  MaintenanceReminder
//
//  Created by YASSINE on 6/7/2023.
//

import SwiftUI

struct CarsView: View {
    @State var userCars : [CarModelWithReminders] = []
    @State var notAuthenticated = false
    @State var error = false
    @ObservedObject var carDataModel = CarDataModel()
    @ObservedObject var userModel = UserNameModel()
    @ObservedObject var remindersDataModel = RemindersDataModel()
    @GestureState private var dragOffset : CGFloat  = 0
    @State private var currentIndex : Int = 0
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ZStack{
                    VStack(alignment : .leading){
                            Ellipse()
                                .foregroundColor(Color("skyBlue"))
                                .frame(width: 800, height: 500)
                                .shadow(color: .gray, radius: 5, x: 0, y: 2)
                                .position(x: UIScreen.main.bounds.width / 2, y: userCars.count > 0 ? -30 : -120)
                    }.frame( maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    VStack(alignment : .leading){
                        ZStack(alignment : .center){
                            Text("Mon Garage")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .multilineTextAlignment(.center)
                            HStack{
                                Spacer()
                                if userCars.count < 4 {
                                    NavigationLink(destination: AddCarView()){
                                        RoundedSmallButtonView(image: "plus", bgColor: "white", iconColor: "skyBlue").padding()
                                    }
                                }
                            }.frame( maxWidth: .infinity)
                        }
                        Spacer()
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    Spacer()
                    VStack(alignment: .leading){
                        if userCars.count > 0 {
                            ZStack{
                                ForEach(0..<userCars.count, id: \.self) { index in
                                    VStack{
                                        CarCardInfo(id: userCars[index].id, brand: userCars[index].brand, model: userCars[index].model, libelle: userCars[index].libelle , cardColor: "skyBlueLight", textColor: "white")
                                            .opacity(currentIndex == index ? 1.0 : 0.5)
                                            .scaleEffect(currentIndex == index ? 1 : 0.8)
                                            .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                                        Divider()
                                            .padding(.top)
                                            .padding(.horizontal, 45.0)
                                            .opacity(currentIndex == index ? 1.0 : 0.5)
                                            .scaleEffect(currentIndex == index ? 1 : 0.8)
                                            .offset(x: CGFloat(index - currentIndex) * 280 + dragOffset, y: 0)
                                        
                                        carReminders(reminders: userCars[index].reminders, dragOffset: dragOffset, currentIndex: $currentIndex, index: index)
                                        
                                        Spacer()
                                    }.alignmentGuide(.top) { _ in 0 }
                                }
                            }.gesture(
                                DragGesture()
                                    .onEnded({ value in
                                        let threshold: CGFloat = 50
                                        if value.translation.width > threshold {
                                            withAnimation{
                                                currentIndex = max(0, currentIndex-1)
                                            }
                                        } else if value.translation.width < -threshold {
                                            withAnimation{
                                                currentIndex = min(userCars.count - 1, currentIndex + 1)
                                            }
                                        }
                                    })
                            )
                            
                            
                        }else{
                            Text("Vous n'avez pas de voitures enregistrés.\nVeuillez ajouter une !")
                                .foregroundColor(Color("primaryTextColor"))
                                .padding(.top, 50.0)
                            
                        }
                        Spacer()
                    }.padding(.top, 100)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Spacer()
                }.navigationBarBackButtonHidden(true)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
            }.onAppear(){
                //Get User's Cars
                Task{
                    await userModel.verify()
                    if !userModel.isAuthenticated {
                        notAuthenticated = true
                    }
                    await carDataModel.getAll()
                    if carDataModel.showError {
                        error = true
                    }
                    userCars = carDataModel.dataFound
                }
            }.navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $notAuthenticated) {
                    HomeView()
                }
                .navigationDestination(isPresented: $error) {
                    RefreshCarsView()
                }
                
        }.refreshable {
            Task{
                await carDataModel.getAll()
                userCars = carDataModel.dataFound
                if carDataModel.showError {
                    error = true
                }
                userCars = carDataModel.dataFound
            }
        }
    }
}

struct CarsView_Previews: PreviewProvider {
    static var previews: some View {
        CarsView()
    }
}

struct carReminders : View {
    @State var reminders : [Reminders] = []
    @GestureState var dragOffset : CGFloat
    @Binding var currentIndex : Int
    @State var index : Int
    var body: some View{
        ForEach(0..<reminders.count, id: \.self) { rem in
            CarReminders(
                reminder: reminders[rem])
                .opacity(currentIndex == index ? 1.0 : 0)
                .scaleEffect(currentIndex == index ? 1 : 0)
                .offset(x: CGFloat(index - currentIndex) * 280 + dragOffset, y: 0)
        }
    }
}
