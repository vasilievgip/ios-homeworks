//
//  ViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 10.04.2022.
//

import UIKit

class FeedViewController: UIViewController {

    let label = UILabel()
    let pushButton = UIButton()
    var post = Post(title: "Мой пост")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.label.text = "Лента"
        self.view.addSubview(label)
        self.label.frame = CGRect(x: 170, y: 50, width: 100, height: 100)
        self.pushButton.setTitle("Перейти на пост", for: .normal)
        self.pushButton.setTitleColor(.black, for: .normal)
        self.view.addSubview(pushButton)
        self.pushButton.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        self.pushButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    @objc
    func handleButtonTap() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
        postViewController.titlePost = post.title
    }

}

