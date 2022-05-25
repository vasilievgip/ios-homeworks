//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 14.05.2022.
//

import UIKit

class ProfileViewController1: UIViewController {

    let profileHeaderView = ProfileHeaderView()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.label.text = "Профиль"
        self.view.addSubview(label)
        self.view.addSubview(profileHeaderView)
        self.label.frame = CGRect(x: 160, y: 0, width: 200, height: 100)
        self.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 1)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.width - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }

}
