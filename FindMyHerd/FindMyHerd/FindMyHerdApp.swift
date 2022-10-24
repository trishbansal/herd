//
//  FindMyHerdApp.swift
//  FindMyHerd
//
//  Created by Shayna Kaushal on 10/17/22.
//

import SwiftUI
import UIKit
import FirebaseCore

//@main
//struct FindMyHerdApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
