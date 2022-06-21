//
//  ViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 10.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Лента"
        label.frame = CGRect(x: 170, y: 50, width: 100, height: 100)
        return label
    }()
    var post = Post(title: "Мой пост")
    private let button1: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    private let button2: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private func layout() {
        [button1, button2].forEach{ stackView.addArrangedSubview($0)}
        view.addSubview(label)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        layout()
        self.button1.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        self.button2.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        self.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
    }
    
    @objc
    func handleButtonTap() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
        postViewController.titlePost = post.title
    }
    
}

