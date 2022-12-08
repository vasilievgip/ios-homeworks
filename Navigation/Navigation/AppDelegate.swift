//
//  AppDelegate.swift
//  Navigation
//
//  Created by Андрей Васильев on 10.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainTabBarController()
        self.window?.makeKeyAndVisible()
        //        if let appConfiguration = AppConfiguration.allCases.randomElement() {
        //            NetworkService.request(for: appConfiguration)
        //        }
        return true

    }
    
}
