//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Андрей Васильев on 14.11.2022.
//

import Foundation
import UIKit

class LoginCoordinator: AppCoordinator {

    var childs =  [AppCoordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainProfileCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ProfileViewController.defaultViewController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func viewPhotos() {
        let vc = PhotosViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func didLogin() {
        parentCoordinator?.childDidFinish(self)
    }

}



