//
//  RootCoordinator.swift
//  Navigation
//
//  Created by Андрей Васильев on 09.11.2022.
//

import Foundation
import UIKit


final class MainFeedCoordinator: AppCoordinator {

    var childs =  [AppCoordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = FeedViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func showPost() {
        let child = PostCoordinator(navigationController: navigationController)
        childs.append(child)
        child.parentCoordinator = self
        child.start()
    }

    func childDidFinish(_ child: AppCoordinator?) {
        for (index, appcoordinator) in childs.enumerated() {
            if appcoordinator === child {
                childs.remove(at: index)
                break
            }
        }
    }

}
