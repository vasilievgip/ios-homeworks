//
//  AppDelegate.swift
//  Navigation
//
//  Created by Андрей Васильев on 10.04.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainTabBarController()
        self.window?.makeKeyAndVisible()
        FirebaseApp.configure()
        //        if let appConfiguration = AppConfiguration.allCases.randomElement() {
        //            NetworkService.request(for: appConfiguration)
        //        }
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        return true

    }

    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}
