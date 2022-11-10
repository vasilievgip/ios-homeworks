//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Андрей Васильев on 09.11.2022.
//

import Foundation
import UIKit


final class MainProfileCoordinator: AppCoordinator {

    var childs =  [AppCoordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = LogInViewController()
        vc.loginDelegate = MyLoginFactory().makeLoginInspector()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func login() {
        let child = LoginCoordinator(navigationController: navigationController)
        childs.append(child)
        child.parentCoordinator = self
        child.start()
        print(childs)
    }

    func childDidFinish(_ child: AppCoordinator?) {
        for (index, appcoordinator) in childs.enumerated() {
            if appcoordinator === child {
                childs.remove(at: index)
                print(childs)
                break
            }
        }
    }

}
