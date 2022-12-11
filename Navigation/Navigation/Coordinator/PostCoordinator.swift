//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Андрей Васильев on 10.11.2022.
//

import Foundation
import UIKit


final class PostCoordinator: AppCoordinator {

    var childs =  [AppCoordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainFeedCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
//        let vc = PostViewController()
        let vc = InfoViewController()
//        let posti = Posti(title: "Мой пост")
        vc.coordinator = self
//        vc.titlePost = posti.title
        navigationController.pushViewController(vc, animated: true)
    }

    func didshowPost() {
        parentCoordinator?.childDidFinish(self)
    }

}
