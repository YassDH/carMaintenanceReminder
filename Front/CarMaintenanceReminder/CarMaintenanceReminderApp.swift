//
//  CarMaintenanceReminderApp.swift
//  CarMaintenanceReminder
//
//  Created by YASSINE on 19/7/2023.
//

import SwiftUI

@main
struct CarMaintenanceReminderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}
