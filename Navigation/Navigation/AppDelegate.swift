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

//        func feedViewController() -> UINavigationController {
//            let feedViewController = FeedViewController()
//            feedViewController.title = "Лента пользователя"
//            feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "ellipsis.bubble"), tag: 0)
//            return UINavigationController (rootViewController: feedViewController)
//        }
        let feedViewController = FeedViewController()

//        func profileViewController() -> UINavigationController {
//            let profileViewController = ProfileViewController()
//            profileViewController.title = "Профиль пользователя"
//            profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 1)
//            return UINavigationController (rootViewController: profileViewController)
//        }
        let profileViewController = ProfileViewController()

//        func tabBarController() -> UITabBarController {
//            let tabBarController = UITabBarController()
//            UITabBar.appearance().backgroundColor = .systemBackground
//            tabBarController.viewControllers = [feedViewController(), profileViewController()]
//            return tabBarController
//        }
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
