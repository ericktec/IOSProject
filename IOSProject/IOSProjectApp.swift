//
//  IOSProjectApp.swift
//  IOSProject
//
//  Created by Erick Mendoza on 01/05/22.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct IOSProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
