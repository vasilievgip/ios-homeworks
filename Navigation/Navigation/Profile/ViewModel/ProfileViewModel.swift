//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Андрей Васильев on 13.11.2022.
//

import Foundation
import UIKit


class ProfileViewModel: AppCoordinator {
    
    var childs =  [AppCoordinator]()
    var user: User
    var navigationController: UINavigationController
    weak var parentCoordinator: MainProfileCoordinator?

    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
    }

    func start() {
        let vc = ProfileViewController()
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
