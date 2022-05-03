//
//  PostViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 01.05.2022.
//

import UIKit

class PostViewController: UIViewController {

    let label = UILabel()
    var titlePost: String = "Что-то"
//    let barButtonItem = UIBarButtonItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.text = titlePost
        self.view.addSubview(label)
        self.label.frame = CGRect(x: 160, y: 100, width: 200, height: 100)
        self.view.backgroundColor = .systemCyan
        let barButtonItem = UIBarButtonItem(title: "Просмотр информации", style: .plain, target: self, action: #selector(handleButtonTap))
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    @objc
    func handleButtonTap() {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true)
    }

}
