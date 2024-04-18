//
//  AppDelegate.swift
//  DodamDodam
//
//  Created by Mercen on 4/18/24.
//

import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
