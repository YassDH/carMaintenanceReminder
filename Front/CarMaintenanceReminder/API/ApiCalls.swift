//
//  ApiCalls.swift
//  CarMaintenanceReminder
//
//  Created by YASSINE on 24/7/2023.
//

import Foundation
import Combine
class Token : ObservableObject {
    static let userToken = Token()
    @Published var currentToken : String = ""
    func setToken(token : String){
        currentToken = token
    }
}
class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var showError = false
    @Published var errorMessage = ""
    func loginUser(email: String, password: String) async {
        DispatchQueue.main.async{
            self.showError = false
            self.isLoggedIn = false
            self.errorMessage = ""
        }
        guard let url = URL(string: "http://localhost:9000/user/login") else {
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = "Invalid URL"
            }
            return
        }        
        let body: [String: String] = ["email": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch _ {
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = "Veuillez réessayer"
            }
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(tokenModel.self, from: data)
            Token.userToken.setToken(token: response.token)
            DispatchQueue.main.async{
                self.isLoggedIn = true
            }
        } catch {
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let errorJSON = try? JSONDecoder().decode(errorModel.self, from: data)
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = errorJSON?.message ?? ""
                }
            }catch{
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
                }
            }
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
            }
        }
    }
}
class RegisterViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var showError = false
    @Published var errorMessage = ""
    func registerUser(username: String, email: String, password: String, confirmPassword: String) async {
        DispatchQueue.main.async{
            self.showError = false
            self.isLoggedIn = false
            self.errorMessage = ""
        }
        guard let url = URL(string: "http://localhost:9000/user/register") else {
            self.showError = true
            self.errorMessage = "Invalid URL"
            return
        }
        let body: [String: String] = ["username" : username, "email" : email, "password" : password, "confirmPassword" : confirmPassword]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch _ {
            self.showError = true
            self.errorMessage = "Veuillez réessayer"
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(tokenModel.self, from: data)
            Token.userToken.setToken(token: response.token)
            DispatchQueue.main.async{
                self.isLoggedIn = true
            }
        } catch {
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let errorJSON = try? JSONDecoder().decode(errorModel.self, from: data)
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = errorJSON?.message ?? ""
                }
            }catch{
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
                }
            }
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
            }
        }
    }
}
class CloseRemindersModel: ObservableObject {
    @Published var dataFound : SortedRemindersStruct? = nil
    @Published var showError = false
    @Published var errorMessage = ""
    func getAll() async {
        DispatchQueue.main.async{
            self.showError = false
            self.errorMessage = ""
        }
        guard let url = URL(string: "http://localhost:9000/reminders/sortedall") else {
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = "Invalid URL"
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Token.userToken.currentToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(SortedRemindersStruct.self, from: data)
            DispatchQueue.main.async{
                self.dataFound = response
            }
        } catch {
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let errorJSON = try? JSONDecoder().decode(errorModel.self, from: data)
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = errorJSON?.message ?? ""
                }
            }catch{
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
                }
            }
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
            }
        }
    }
}
class UserNameModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var dataFound : String = ""
    @Published var showError = false
    @Published var errorMessage = ""
    func get() async {
        DispatchQueue.main.async{
            self.showError = false
            self.errorMessage = ""
        }
        guard let url = URL(string: "http://localhost:9000/user/name") else {
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = "Invalid URL"
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Token.userToken.currentToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(errorModel.self, from: data)
            DispatchQueue.main.async{
                self.dataFound = response.message
            }
        } catch {
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let errorJSON = try? JSONDecoder().decode(errorModel.self, from: data)
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = errorJSON?.message ?? ""
                }
            }catch{
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
                }
            }
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
            }
        }
    }
    func verify() async {
        DispatchQueue.main.async{
            self.showError = false
            self.errorMessage = ""
        }
        guard let url = URL(string: "http://localhost:9000/user/verify") else {
            DispatchQueue.main.async{
                self.isAuthenticated = false
                self.showError = true
                self.errorMessage = "Invalid URL"
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Token.userToken.currentToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(authenticationModel.self, from: data)
            DispatchQueue.main.async{
                self.isAuthenticated = response.authenticated
            }
        } catch {
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let errorJSON = try? JSONDecoder().decode(authenticationModel.self, from: data)
                DispatchQueue.main.async{
                    self.isAuthenticated = errorJSON?.authenticated ?? false
                    self.showError = true
                }
            }catch{
                DispatchQueue.main.async{
                    self.isAuthenticated = false
                    self.showError = true
                    self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
                }
            }
            DispatchQueue.main.async{
                self.isAuthenticated = false
                self.showError = true
                self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
            }
        }
    }
}
class CarDataModel: ObservableObject {
    @Published var dataFound : [CarModelWithReminders] = []
    @Published var showError = false
    @Published var sucess = false
    @Published var errorMessage = ""
    func addCar(brand: String, model: String, libelle: String) async {
        DispatchQueue.main.async{
            self.showError = false
            self.sucess = false
            self.errorMessage = ""
        }
        guard let url = URL(string: "http://localhost:9000/cars/add") else {
            self.showError = true
            self.errorMessage = "Invalid URL"
            return
        }
        let body: [String: String] = ["brand" : brand, "model" : model, "libelle" : libelle]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(Token.userToken.currentToken)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch _ {
            self.showError = true
            self.errorMessage = "Veuillez réessayer"
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(errorModel.self, from: data)
            DispatchQueue.main.async{
                if response.status == "sucess" {
                    self.sucess = true
                    self.showError = false
                }else{
                    self.sucess = false
                    self.showError = true
                    self.errorMessage = response.message
                }
            }
        } catch {
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let errorJSON = try? JSONDecoder().decode(errorModel.self, from: data)
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = errorJSON?.message ?? ""
                }
            }catch{
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
                }
            }
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
            }
        }
    }
    func getAll() async {
        DispatchQueue.main.async{
            self.showError = false
            self.errorMessage = ""
        }
        guard let url = URL(string: "http://localhost:9000/cars") else {
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = "Invalid URL"
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Token.userToken.currentToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(CarModelData.self, from: data)
            DispatchQueue.main.async{
                self.dataFound = response.data
            }
        } catch {
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let errorJSON = try? JSONDecoder().decode(errorModel.self, from: data)
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = errorJSON?.message ?? ""
                }
            }catch{
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
                }
            }
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
            }
        }
    }
    
    func deleteCar(carID : Int) async {
        DispatchQueue.main.async{
            self.showError = false
            self.errorMessage = ""
        }
        guard let url = URL(string: "http://localhost:9000/cars/\(carID)") else {
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = "Invalid URL"
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(Token.userToken.currentToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(errorModel.self, from: data)
            DispatchQueue.main.async{
                if response.status == "sucess" {
                    self.sucess = true
                }else{
                    self.showError = true
                    self.errorMessage = response.message
                }
            }
        } catch {
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let errorJSON = try? JSONDecoder().decode(errorModel.self, from: data)
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = errorJSON?.message ?? ""
                }
            }catch{
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
                }
            }
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
            }
        }
    }
}
class RemindersDataModel: ObservableObject {
    @Published var sucess = false
    @Published var showError = false
    @Published var errorMessage = ""
    func formatDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }
    func addReminder(carID: Int, name: String, beginDate: Date, distance: Int, timePeriodicity: Int, distancePeriodicity: Int, price: Double ) async {
        DispatchQueue.main.async{
            self.showError = false
            self.sucess = false
            self.errorMessage = ""
        }
        guard let url = URL(string: "http://localhost:9000/reminders/add/\(carID)") else {
            self.showError = true
            self.errorMessage = "Invalid URL"
            return
        }
        let dateFormated = formatDateToString(date: beginDate)
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(Token.userToken.currentToken)", forHTTPHeaderField: "Authorization")
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        do {
            let body = ReminderToAdd(name: name, beginDate: dateFormated, price: price, distance: distance, timePeriodicty: timePeriodicity, distancePeriodicty: distancePeriodicity)
            let jsonData = try jsonEncoder.encode(body)
            request.httpBody = jsonData
        } catch {
            self.showError = true
            self.errorMessage = "Veuillez réessayer"
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(errorModel.self, from: data)
            DispatchQueue.main.async{
                if response.status == "sucess" {
                    self.sucess = true
                    self.showError = false
                }else{
                    self.sucess = false
                    self.showError = true
                    self.errorMessage = response.message
                }
            }
        } catch {
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let errorJSON = try? JSONDecoder().decode(errorModel.self, from: data)
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = errorJSON?.message ?? ""
                }
            }catch{
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
                }
            }
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
            }
        }
    }
    func delete(reminderId : Int) async {
        DispatchQueue.main.async{
            self.showError = false
            self.errorMessage = ""
        }
        guard let url = URL(string: "http://localhost:9000/reminders/\(reminderId)") else {
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = "Invalid URL"
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(Token.userToken.currentToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(errorModel.self, from: data)
            DispatchQueue.main.async{
                if response.status == "sucess"{
                    self.sucess = true
                }else{
                    self.showError = true
                    self.errorMessage = response.message
                }
                
            }
        } catch {
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let errorJSON = try? JSONDecoder().decode(errorModel.self, from: data)
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = errorJSON?.message ?? ""
                }
            }catch{
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
                }
            }
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
            }
        }
    }
    func reset(reminderId : Int) async {
        DispatchQueue.main.async{
            self.showError = false
            self.errorMessage = ""
        }
        guard let url = URL(string: "http://localhost:9000/reminders/reset/\(reminderId)") else {
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = "Invalid URL"
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(Token.userToken.currentToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(errorModel.self, from: data)
            DispatchQueue.main.async{
                if response.status == "sucess"{
                    self.sucess = true
                }else{
                    self.showError = true
                    self.errorMessage = response.message
                }
                
            }
        } catch {
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let errorJSON = try? JSONDecoder().decode(errorModel.self, from: data)
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = errorJSON?.message ?? ""
                }
            }catch{
                DispatchQueue.main.async{
                    self.showError = true
                    self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
                }
            }
            DispatchQueue.main.async{
                self.showError = true
                self.errorMessage = self.errorMessage != "" ? self.errorMessage : "Veuillez réessayer"
            }
        }
    }
}
