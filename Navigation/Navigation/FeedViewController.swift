//
//  ViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 10.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Лента"
        label.frame = CGRect(x: 170, y: 50, width: 100, height: 100)
        return label
    }()
    var post = Post(title: "Мой пост")
    let button1: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    let button2: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.label.text = "Лента"
        self.view.addSubview(label)
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(button1)
        self.stackView.addArrangedSubview(button2)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        self.button1.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        self.button2.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    @objc
    func handleButtonTap() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
        postViewController.titlePost = post.title
    }
    
}

