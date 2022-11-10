//
//  MainTabBarControllerViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 10.11.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    let mainFeedCoordinator = MainFeedCoordinator(navigationController: UINavigationController())
    let mainProfileCoordinator = MainProfileCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainFeedCoordinator.start()
        self.mainFeedCoordinator.navigationController.navigationBar.isHidden = true

        self.mainProfileCoordinator.start()
        self.mainProfileCoordinator.navigationController.navigationBar.isHidden = true
        
        self.viewControllers = [
            self.mainFeedCoordinator.navigationController,
            self.mainProfileCoordinator.navigationController
        ]
    }

}
