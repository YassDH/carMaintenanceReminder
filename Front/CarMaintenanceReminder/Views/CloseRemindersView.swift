//
//  CloseRemindersView.swift
//  MaintenanceReminder
//
//  Created by YASSINE on 18/7/2023.
//

import SwiftUI

struct CloseRemindersView: View {
    @State var nextPage = false
    @State var newCarPage = false
    @State var notAuthenticated = false
    @State private var currentIndex : Int = 0
    @GestureState private var dragOffset : CGFloat  = 0
    @ObservedObject var closeRemindersModel = CloseRemindersModel()
    @State var reminders : SortedRemindersStruct? = nil
    @ObservedObject var userNameModel : UserNameModel = UserNameModel()
    @State var redNumb = 0
    @State var yellowNumb = 0
    @State var greenNumb = 0
    @State var userName = ""
    @State var remindersArray : [ReminderModel] = []
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading){
                    VStack(alignment : .leading){
                        HStack(alignment : .center){
                            ( Text("Bonjour, ")
                                .fontWeight(.semibold) +
                              Text(userName))
                                .fontWeight(.bold)
                                .foregroundColor(Color("skyBlue"))
                                .font(.system(size: 30))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .padding(.leading)
                    }.frame(maxWidth: .infinity)
                    Spacer()
                    VStack{
                        Text("Vos rappels les plus proches :")
                            .frame(maxWidth: .infinity ,alignment: .leading)
                            .padding(.horizontal)
                            .foregroundColor(Color("skyBlue"))
                            .bold()
                    }.padding(.top)
                        .frame(maxHeight: .infinity)
                    Spacer()
                    
                    ZStack{
                        if remindersArray.count == 0 {
                            VStack{
                                VStack(alignment: .leading){
                                    HStack{
                                        Spacer()
                                        ZStack{
                                            Image(systemName: "exclamationmark.triangle.fill")
                                                    .foregroundColor(Color("customDarkGray"))
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 30))
                                            Circle()
                                                .trim(from: 0.0, to: 1.0)
                                                .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
                                                .foregroundColor(Color("customDarkGray"))
                                                .rotationEffect(Angle(degrees: 270))
                                        }.frame(width: 60, height: 60)
                                        Spacer()
                                    }
                                    Spacer()
                                    Spacer()
                                    Divider()
                                    Spacer()
                                    VStack(alignment: .center){
                                        Text("Vous n'avez pas de rappels.")
                                        Text("Veuillez en ajouter !")
                                    }.frame(maxWidth: .infinity)
                                }
                                    .padding(.all)
                                    .frame(maxWidth: .infinity ,alignment: .leading)
                                    .background(Color("customLightGray"))
                                    .foregroundColor(Color("customDarkInfo"))
                                    .cornerRadius(20)
                                    .shadow(color: Color("customLightGray"), radius: 5, x: 0, y: 2)
                                Spacer()
                            }.padding(.horizontal)
                                .frame(maxHeight: .infinity)
                        }else{
                            ForEach(0..<remindersArray.count, id: \.self) { index in
                                VStack{
                                    if redNumb != 0 && index < redNumb {
                                        //SHOW RED CARD
                                        ProgressCardView(bgColor: "customRed", progressBarColor: "customWhiteRed", textColor: "white", reminder: remindersArray[index])
                                            .scaleEffect(currentIndex == index ? 1 : 0.9)
                                            .offset(x: CGFloat(index - currentIndex) * 175 + dragOffset, y: 0)
                                            .padding(.bottom, 30)
                                    }else if (yellowNumb != 0) && ((redNumb != 0 && index < redNumb+yellowNumb)||(redNumb == 0 && index < yellowNumb)){
                                        //SHOW YELLOW CARD
                                            ProgressCardView(bgColor: "customYellow", progressBarColor: "customDarkYellow", textColor: "customDarkYellow", reminder: remindersArray[index])
                                                .scaleEffect(currentIndex == index ? 1 : 0.9)
                                                .offset(x: CGFloat(index - currentIndex) * 175 + dragOffset, y: 0)
                                                .padding(.bottom, 30)
                                    }else{
                                        //SHOW GREEN CARD
                                    ProgressCardView(bgColor: "customGreen", progressBarColor: "customWhiteGreen", textColor: "white", reminder: remindersArray[index])
                                        .scaleEffect(currentIndex == index ? 1 : 0.9)
                                        .offset(x: CGFloat(index - currentIndex) * 175 + dragOffset, y: 0)
                                        .padding(.bottom, 30)
                                    }
                                
                                }.alignmentGuide(.top) { _ in 0 }
                            }
                        }
                    }
                    .padding(.top, 30.0)
                    .padding(.horizontal)
                    .gesture(
                        DragGesture()
                            .onEnded({ value in
                                let threshold: CGFloat = 50
                                if value.translation.width > threshold {
                                    withAnimation{
                                        currentIndex = max(0, currentIndex-1)
                                    }
                                } else if value.translation.width < -threshold {
                                    withAnimation{
                                        currentIndex = min(10 - 1, currentIndex + 1)
                                    }
                                }
                            })
                    )
                    VStack{
                        Text("Vous avez :")
                            .padding(.bottom)
                            .frame(maxWidth: .infinity ,alignment: .leading)
                            .foregroundColor(Color("skyBlue"))
                            .bold()
                        VStack(alignment: .leading){
                            HStack{
                                Text(String(redNumb))
                                    .bold()
                                    .foregroundColor(Color("customRed"))
                                Text("Rappels qui expirent ce mois")
                            }
                            Spacer()
                            Divider()
                            HStack{
                                Text(String(yellowNumb))
                                    .bold()
                                    .foregroundColor(Color("customDarkYellow"))
                                Text("Rappels qui expirent dans 2 mois")
                            }
                            Spacer()
                            Divider()
                            HStack{
                                Text(String(greenNumb))
                                    .bold()
                                    .foregroundColor(Color("customGreen"))
                                Text("Rappels qui expirent dans plus que 2 mois")
                            }
                        }
                            .padding(.all)
                            .frame(maxWidth: .infinity ,alignment: .leading)
                            .background(Color("customInfo"))
                            .foregroundColor(Color("customDarkInfo"))
                            .cornerRadius(20)
                            .shadow(color: Color("customInfo"), radius: 5, x: 0, y: 2)
                    }.padding(.horizontal)
                        .frame(maxHeight: .infinity)
                    Spacer()
                    Button (action: {
                        nextPage = true
                    }, label: {
                        CustomButton(title: "Gérer mes rappels", bgColor: "skyBlue", labelColor: "white")
                    })
                    .padding()
                }
                .padding(.vertical)
                .padding(.horizontal)
            }.navigationDestination(isPresented: $nextPage) {
                    CarsView()
                }.navigationDestination(isPresented: $newCarPage) {
                    AddCarView()
                }.navigationDestination(isPresented: $notAuthenticated) {
                    HomeView()
                }
        }.navigationBarBackButtonHidden(true)
            .onAppear(){
                Task{
                    await userNameModel.get()
                    if(!userNameModel.showError){
                        userName = userNameModel.dataFound
                    }else{
                        notAuthenticated = true
                    }
                    await closeRemindersModel.getAll()
                    if(!closeRemindersModel.showError){
                        reminders = closeRemindersModel.dataFound
                        redNumb = reminders!.data.red.count
                        yellowNumb = reminders!.data.yellow.count
                        greenNumb = reminders!.data.green.count
                        remindersArray = reminders!.data.red + reminders!.data.yellow + reminders!.data.green
                    }else{
                        notAuthenticated = true
                    }
                }
            }
    }
}

struct CloseRemindersView_Previews: PreviewProvider {
    static var previews: some View {
        CloseRemindersView()
    }
}
