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
        let loginViewController = LogInViewController()
        let navigationFeedViewController = UINavigationController(rootViewController: feedViewController)
        let navigationLoginViewController = UINavigationController(rootViewController: loginViewController)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            navigationFeedViewController,
            navigationLoginViewController
        ]
        navigationFeedViewController.navigationBar.isHidden = true
        navigationLoginViewController.navigationBar.isHidden = true
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        return true
        
    }
    
}
