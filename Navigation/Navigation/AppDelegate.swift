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
        
        let feedViewController = FeedViewController()
        let profileViewController = ProfileViewController()
        let navigationVC = UINavigationController(rootViewController: feedViewController)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            navigationVC,
            profileViewController
        ]
        navigationVC.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "ellipsis.bubble"), tag: 0)
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        return true
    }
    
}
