//
//  CustomViews.swift
//  MaintenanceReminder
//
//  Created by YASSINE on 5/7/2023.
//

import Foundation
import SwiftUI

struct CustomViews: View {
    @State private var username : String = ""
    var body: some View {
        CarCardInfo(id: 1, brand: "Ford", model: "Focus" ,libelle: "123 TU 1234" , cardColor: "skyBlue", textColor: "white")
    }
}

struct CustomViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CustomViews()
            //CarReminders(reminderName: "Nom du Rappel", beginDate: Date(), futureDate: Date(), distance: "")
        }
    }
}

struct CustomButton : View {
    
    var title : String
    var bgColor : String
    var labelColor : String
    
    var body: some View{
        Text(title)
            .fontWeight(.bold)
            .foregroundColor(Color(labelColor))
            .frame(height: 50)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color(bgColor))
            .cornerRadius(30)
    }
}

struct CustomTextField : View {
    var password : Bool
    var placeHolder : String
    var imageName : String
    var bColor : String
    var tOpacity : Double
    @Binding var value : String
    var body: some View{
        HStack{
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding(.leading, 20)
                .foregroundColor(Color(bColor).opacity(tOpacity))
                
            if password == true    {
                ZStack(alignment: .leading){
                    if value.isEmpty {
                        Text(placeHolder)
                            .foregroundColor(Color(bColor).opacity(tOpacity))
                            .padding(.leading , 12)
                            .font(.system(size: 20))
                    }
                    SecureField("", text: $value)
                        .padding(.leading, 12)
                        .font(.system(size: 20))
                        .frame(height: 45)
                }.overlay(
                    Divider()
                        .overlay(
                            Color(bColor).opacity(tOpacity)
                        )
                    ,alignment: .leading
                )
            }else{
                ZStack(alignment: .leading){
                    if value.isEmpty {
                        Text(placeHolder)
                            .foregroundColor(Color(bColor).opacity(tOpacity))
                            .padding(.leading , 12)
                            .font(.system(size: 20))
                    }
                    TextField("", text: $value)
                        .padding(.leading, 12)
                        .font(.system(size: 20))
                        .frame(height: 45)
                        .foregroundColor(Color(bColor))
                    
                }.overlay(
                    Divider()
                        .overlay(
                            Color(bColor).opacity(tOpacity)
                        )
                    ,alignment: .leading
                )
            }
        }
        .background(Color("inputBG"))
        .cornerRadius(30)
        .padding()
        
        
    }
}

struct BackButtonView : View{
    var body: some View{
        Image(systemName: "arrow.backward")
            .resizable()
            .frame(width: 30.0, height: 25.0)
            .padding(.horizontal, 20)
            .foregroundColor(Color("skyBlue"))
    }
}

struct RoundedSmallButtonView : View {
    var image : String
    var bgColor : String
    var iconColor : String
    var body: some View{
        VStack{
            Image(systemName: image)
                .resizable()
                .foregroundColor(Color(iconColor))
                .frame(width: 30, height: 30)
                .fontWeight(.semibold)
                
        }
        .frame(width: 50, height: 50)
        .background(Color(bgColor))
        .cornerRadius(100)
    }
}


struct CarCardInfo : View{
    var id : Int
    var brand : String
    var model : String
    var libelle : String
    var cardColor : String
    var textColor : String
    @State var active : Bool = false
    @State var activeReminder : Bool = false
    @State var showError : Bool = false
    @ObservedObject var carDataModel = CarDataModel()

    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    
    var body: some View{
        ZStack(alignment: .topLeading){
            Text("")
                .frame(maxWidth: 300, maxHeight: 250)
            VStack(alignment: .leading){
                Text(brand)
                    .fontWeight(.semibold)
                    .font(.system(size: 40))
                Text(model)
                    .font(.system(size: 25))
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "newspaper")
                        Text(libelle)
                    }.padding()
                }.font(.system(size: 17))
                    .background(Color("darkBGTransparent"))
                    .cornerRadius(15)
                    .frame(maxWidth: 300, maxHeight: 250)
                Spacer()
                HStack{
                    
                        Button {
                            Task{
                                self.showError = false
                                await carDataModel.deleteCar(carID: id)
                                if carDataModel.showError {
                                    self.showError = true
                                }else{
                                    self.active = true
                                }
                                
                            }
                            active = true
                        } label: {
                            RoundedSmallButtonView(image: "multiply", bgColor: "white", iconColor: "skyBlue")
                        }
                
                    Spacer()
                    
                        Button {
                            activeReminder = true
                        } label: {
                            VStack(alignment: .trailing){
                                Text("Ajouter un")
                                Text("Rappel")
                            }.foregroundColor(Color(textColor))
                                .bold()
                            RoundedSmallButtonView(image: "plus", bgColor: "white", iconColor: "skyBlue")
                        }
                    
                }
            }
                .padding()
                .foregroundColor(Color(textColor))
        }.background(Color(cardColor))
            .cornerRadius(15)
            .frame(maxWidth: 320, maxHeight: 250)
            .shadow(color: Color(cardColor), radius: 5, x: 0, y: 2)
            .navigationDestination(isPresented: $active) {
                RefreshCarsView()
            }
            .navigationDestination(isPresented: $activeReminder) {
                AddReminderView(carId: id)
            }.alert(isPresented: $showError) {
                Alert(title: Text("Erreur !"), message: Text(carDataModel.errorMessage), dismissButton: .default(Text("OK")))
            }
    }
}

struct CarReminders : View {
    
    var reminder : Reminders
    @ObservedObject var remindersDataModel = RemindersDataModel()
    @State var deleted = false
    @State var reseted = false
    @State var showError = false
    
    func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
    
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    func calculateProgress(beginDate : Date ,futureDate: Date) -> Double {
        let currentDate = Date()
        let timeIntervalRemaining = currentDate.timeIntervalSinceReferenceDate - beginDate.timeIntervalSinceReferenceDate
        let totalTimeInterval = futureDate.timeIntervalSinceReferenceDate - beginDate.timeIntervalSinceReferenceDate
        var percentageRemaining = (timeIntervalRemaining / totalTimeInterval)
        percentageRemaining = percentageRemaining > 0 ? percentageRemaining : 0
        percentageRemaining = percentageRemaining <= 1 ? percentageRemaining : 1
        return percentageRemaining
    }
    
    func progressColor(progressValue : Double) -> String {
        if progressValue > 0.5 && progressValue < 0.8 {
             return "yellowAlert"
        }else if progressValue >= 0.8 {
            return "redAlert"
        }else{
            return "greenAlert"
        }
    }
    
    func progressIcon(progressValue : Double) -> String {
        if progressValue > 0.5 && progressValue < 0.8 {
             return "exclamationmark.circle.fill"
        }else if progressValue >= 0.8 {
            return "exclamationmark.triangle.fill"
        }else{
            return "checkmark.circle.fill"
        }
    }
    
    func addMonths(originalDate: Date, monthsToAdd: Int) -> Date? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = monthsToAdd
        return calendar.date(byAdding: dateComponents, to: originalDate)
    }
    
    var body: some View{
        VStack{
            ZStack(alignment: .topLeading){
                Text("")
                    .frame(maxWidth: 300)
                VStack(alignment: .leading){
                    Text(reminder.name)
                        .font(.system(size: 25))
                        .bold()
                    Text(reminder.timePeriodicty != 0 ? "Date d'Expiration : " : "Date de maintenance :")
                        .font(.system(size: 15))
                        .fontWeight(.light)
                    Text(formatter.string(from: addMonths(originalDate: dateFromString(reminder.beginDate)!,monthsToAdd: reminder.timePeriodicty)!))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    if reminder.distancePeriodicty != 0 {
                        Text("Kilomètrage à ne pas dépasser : ")
                            .font(.system(size: 15))
                            .fontWeight(.light)
                        HStack{
                            Text(String(reminder.distance+reminder.distancePeriodicty))
                            Text("km")
                        }.font(.system(size: 15))
                         .fontWeight(.semibold)
                    }
                    Text("Montant payé : ")
                        .font(.system(size: 15))
                        .fontWeight(.light)
                    HStack{
                        Text(String(reminder.price))
                        Text("DT")
                    }.font(.system(size: 15))
                     .fontWeight(.semibold)
                    if reminder.timePeriodicty != 0 {
                        HStack{
                            let progressValue = calculateProgress(beginDate: dateFromString(reminder.beginDate)!,futureDate: addMonths(originalDate: dateFromString(reminder.beginDate)!,monthsToAdd: reminder.timePeriodicty)!)
                            let progressColor = progressColor(progressValue: progressValue)
                            ProgressView(value: progressValue).accentColor(Color(progressColor))
                            Image(systemName: progressIcon(progressValue: progressValue))
                                .foregroundColor(Color(progressColor))
                        }
                    }
                    Divider()
                        .padding(.vertical, 5.0)
                    HStack{
                        
                            Button {
                                Task{
                                    await remindersDataModel.reset(reminderId: reminder.id)
                                    if remindersDataModel.sucess {
                                        reseted = true
                                    }else{
                                        showError = true
                                    }
                                }
                            } label: {
                                RoundedSmallButtonView(image: "checkmark", bgColor: "skyBlueLight", iconColor: "white")
                            }
                        
                    
                        Spacer()
                            Button {
                                Task{
                                    await remindersDataModel.delete(reminderId: reminder.id)
                                    if remindersDataModel.sucess {
                                        deleted = true
                                    }else{
                                        showError = true
                                    }
                                }
                            } label: {
                                RoundedSmallButtonView(image: "multiply", bgColor: "skyBlueLight", iconColor: "white")
                            }
                    }
                }
                    .padding()
                    .foregroundColor(Color("skyBlue"))
            }.background(Color("white"))
                .cornerRadius(10)
                .frame(maxWidth: 300)
                .shadow(color: .gray, radius: 5, x: 0, y: 2)
        }.padding(.top)
            .navigationDestination(isPresented: $deleted) {
                
                RefreshCarsView()
            }
            .navigationDestination(isPresented: $reseted) {
                
                RefreshCarsView()
            }.alert(isPresented: $showError) {
                Alert(title: Text("Erreur !"), message: Text(remindersDataModel.errorMessage), dismissButton: .default(Text("OK")))
            }
    }
}
struct CustomDatePicker : View {
    var textContent : String
    @Binding var value : Date
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "calendar")
                Text(textContent)
            }.foregroundColor(Color("primaryTextColor").opacity(0.6))
                .font(.system(size: 20))
                .padding([.top, .leading])
            Divider()
            DatePicker(selection: $value, in: ...Date(), displayedComponents: .date, label: { })
                .datePickerStyle(.graphical)
                .labelsHidden()
                .padding(.horizontal)
        }.background(Color("inputBG"))
            .cornerRadius(30)
            .frame(maxWidth: .infinity)
            .padding()
    }
}


struct CustomPriceField : View {
    var placeHolder : String
    var imageName : String
    var bColor : String
    var tOpacity : Double
    @Binding var value : Double
    let amountFormatter : NumberFormatter = {
              let formatter = NumberFormatter()
              formatter.zeroSymbol = ""
              return formatter
         }()
    var body: some View{
        HStack{
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding(.leading, 20)
                .foregroundColor(Color(bColor).opacity(tOpacity))
                
                ZStack(alignment: .leading){
                    if value == 0 {
                        Text(placeHolder)
                            .foregroundColor(Color(bColor).opacity(tOpacity))
                            .padding(.leading , 12)
                            .font(.system(size: 20))
                    }
                    TextField("", value: $value, formatter: amountFormatter)
                        .keyboardType(.decimalPad)
                        .padding(.leading, 12)
                        .font(.system(size: 20))
                        .frame(height: 45)
                        .foregroundColor(value != 0 ? Color(bColor) : Color("transparent"))
                    
                }.overlay(
                    Divider()
                        .overlay(
                            Color(bColor).opacity(tOpacity)
                        )
                    ,alignment: .leading
                )
        }
        .background(Color("inputBG"))
        .cornerRadius(30)
        .padding()
        
        
    }
}


struct CustomNumberField : View {
    var placeHolder : String
    var imageName : String
    var bColor : String
    var tOpacity : Double
    @Binding var value : Int
    
    let customNumberFormat: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .none
            formatter.zeroSymbol  = ""
            return formatter
        }()
    
    var body: some View{
        HStack{
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding(.leading, 20)
                .foregroundColor(Color(bColor).opacity(tOpacity))
                
                ZStack(alignment: .leading){
                    if value == 0 {
                        Text(placeHolder)
                            .foregroundColor(Color(bColor).opacity(tOpacity))
                            .padding(.leading , 12)
                            .font(.system(size: 20))
                    }
                    TextField("", value: $value, formatter: customNumberFormat)
                        .padding(.leading, 12)
                        .font(.system(size: 20))
                        .frame(height: 45)
                        .foregroundColor(value != 0 ? Color(bColor) : Color("transparent"))
                        .keyboardType(.decimalPad)
                }.overlay(
                    Divider()
                        .overlay(
                            Color(bColor).opacity(tOpacity)
                        )
                    ,alignment: .leading
                )
        }
        .background(Color("inputBG"))
        .cornerRadius(30)
        .padding(.horizontal)
    }
}


struct ToggleNumberField : View {
    var placeholder : String
    var icon : String
    
    
        @State var isToogleOn = false
        @State var textFieldIsDisabled = true
        @Binding var inputValue : Int
        
        var body: some View {
                HStack {
                    Text("Tout les :")
                        .foregroundColor(Color("skyBlue"))
                        .bold()
                        .padding(.leading, 15)
                    Toggle("", isOn: $isToogleOn)
                        .frame(width: 30)
                        .onChange(of: isToogleOn) {
                            newValue in
                            textFieldIsDisabled = !newValue
                        }
                    
                    CustomNumberField(placeHolder: placeholder, imageName: icon, bColor: "primaryTextColor", tOpacity: 0.6, value: $inputValue).disabled(textFieldIsDisabled)
                }.onChange(of: isToogleOn) { newValue in
                    if isToogleOn == false {
                        inputValue = 0
                    }
                }
            
        }
}

struct ProgressCardView : View {
    @State var progress : Double = 0.8
    var bgColor : String
    var progressBarColor : String
    var textColor : String
    var reminder : ReminderModel
    
    func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
    
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    func calculateProgress(beginDate : Date ,futureDate: Date) -> Double {
        let currentDate = Date()
        if currentDate >= futureDate {
            return 1
        }
        let timeIntervalRemaining = currentDate.timeIntervalSinceReferenceDate - beginDate.timeIntervalSinceReferenceDate
        let totalTimeInterval = futureDate.timeIntervalSinceReferenceDate - beginDate.timeIntervalSinceReferenceDate
        var percentageRemaining = (timeIntervalRemaining / totalTimeInterval)
        percentageRemaining = percentageRemaining > 0 ? percentageRemaining : 0
        percentageRemaining = percentageRemaining <= 1 ? percentageRemaining : 1
        return percentageRemaining
    }
    
    func addMonths(originalDate: Date, monthsToAdd: Int) -> Date? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = monthsToAdd
        return calendar.date(byAdding: dateComponents, to: originalDate)
    }
    
    
    
    
    var body: some View{
        VStack(alignment: .leading){
            if reminder.timePeriodicty > 0 {
                CircleProgressBar(progress: $progress, lineColor: progressBarColor, textColor: textColor, kilo: false)
            }else{
                CircleProgressBar(progress: $progress, lineColor: progressBarColor, textColor: textColor, kilo: true)
            }
            Spacer()
            VStack(alignment: .trailing){
                Spacer()
                Spacer()
                HStack{
                    Text(reminder.reminderName)
                    Spacer()
                }
                    .bold()
                    .font(.system(size: 20))
                Spacer()
                HStack{
                    VStack(alignment: .leading){
                        Text("Véhicule :")
                        Text(reminder.carName).bold()
                    }
                    Spacer()
                }.font(.system(size: 15))
                Spacer()
                HStack{
                    VStack(alignment: .leading){
                        Text(reminder.timePeriodicty > 0 ? "Expiration :" : "Kilométrage :")
                        Text(reminder.timePeriodicty > 0 ? formatter.string(from: addMonths(originalDate: dateFromString(reminder.beginDate)!,monthsToAdd: reminder.timePeriodicty)!) : String(reminder.distance)+" km").bold()
                    }
                    Spacer()
                }.font(.system(size: 15))
            }
            .padding(.vertical)
                .frame(width: 120, height: 120)
        }
            .foregroundColor(Color(textColor))
            .padding(25)
            .background(Color(bgColor))
            .cornerRadius(20)
            .shadow(color: Color(bgColor), radius: 5, x: 2, y: 2)
            .onAppear{
                self.progress = calculateProgress(beginDate: dateFromString(reminder.beginDate)!,futureDate: addMonths(originalDate: dateFromString(reminder.beginDate)!,monthsToAdd: reminder.timePeriodicty)!)
            }
    }
}

struct CircleProgressBar : View{
    @Binding var progress : Double
    var lineColor : String
    var textColor : String
    var kilo : Bool
    var body: some View{
        ZStack{
            if !kilo{
                Text(String(Int(ceil(progress*100)))+"%")
                    .foregroundColor(Color(textColor))
                    .fontWeight(.bold)
                    .font(.system(size: 17))
            }else{
                Image(systemName: "gear")
                    .foregroundColor(Color(textColor))
                    .fontWeight(.bold)
                    .font(.system(size: 35))
            }
            Circle()
                .trim(from: 0.0, to: CGFloat(!kilo ? min(self.progress, 1.0) : 1.0))
                .stroke(style: StrokeStyle(lineWidth: 7.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(lineColor))
                .rotationEffect(Angle(degrees: 270))
        }.frame(width: 60, height: 60)
    }
}
