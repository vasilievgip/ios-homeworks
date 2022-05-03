//
//  UITabBarController.swift
//  Navigation
//
//  Created by Андрей Васильев on 19.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    let label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.label.text = "Профиль"
        self.view.addSubview(label)
        self.label.frame = CGRect(x: 160, y: 50, width: 200, height: 100)
        self.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 1)
    }

}
