//
//  Models.swift
//  CarMaintenanceReminder
//
//  Created by YASSINE on 24/7/2023.
//

import Foundation
struct tokenModel : Codable {
    let status : String
    let token : String
}
struct errorModel : Codable {
    let status : String
    let message : String
}
struct authenticationModel : Codable {
    let status : String
    let authenticated : Bool
}
struct ReminderModel : Codable {
    let id : Int
    let reminderName : String
    let carName : String
    let beginDate : String
    let distance : Int
    let timePeriodicty : Int
    let distancePeriodicty : Int
}
struct Reminders : Codable {
    let id : Int
    let name : String
    let beginDate : String
    let distance : Int
    let timePeriodicty : Int
    let distancePeriodicty : Int
    let price : Float
}
struct SortedReminders : Codable {
    let red : [ReminderModel]
    let yellow : [ReminderModel]
    let green : [ReminderModel]
}
struct SortedRemindersStruct : Codable {
    let status : String
    let data : SortedReminders
}
struct CarModelWithReminders : Codable {
    let id : Int
    let brand : String
    let model : String
    let libelle : String
    let reminders : [Reminders]
}
struct CarModelData : Codable {
    let status : String
    let data : [CarModelWithReminders]
}
struct CarsReminders : Codable {
    let status : String
    let data : [ReminderModel]
}
struct ReminderToAdd : Codable {
    let name : String
    let beginDate : String
    let price : Double
    let distance : Int
    let timePeriodicty : Int
    let distancePeriodicty : Int
}
