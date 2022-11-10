//
//  ViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 10.04.2022.
//

import UIKit

class FeedViewController: UIViewController {

    weak var coordinator: MainFeedCoordinator?

    let feedModel = FeedModel()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Лента"
        label.frame = CGRect(x: 170, y: 50, width: 100, height: 100)
        return label
    }()

    private let secretWordtextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .systemGray6
        field.placeholder = "secret Word"
        field.textColor = .black
        field.font = . systemFont(ofSize: 16)
        field.tintColor = UIColor(named: "Color_IOS20")
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.indent(size: 10)
        field.toAutoLayout()
        return field
    }()

    private let checkGuessButton = CustomButton(title: "Проверить",
                                                titleColor: .white,
                                                backgroundColor: UIColor(named: "Color_IOS20"),
                                                cornerRadius: 10)

    private  let secretWordLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.toAutoLayout()
        return label
    }()

//    var posti = Posti(title: "Мой пост")

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
        stackView.toAutoLayout()
        return stackView
    }()

    private func layout() {
        [button1, button2].forEach{ stackView.addArrangedSubview($0)}
        view.addSubviews(label, stackView, secretWordtextField, checkGuessButton, secretWordLabel)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            secretWordtextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            secretWordtextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secretWordtextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            secretWordtextField.heightAnchor.constraint(equalToConstant: 50),
            checkGuessButton.topAnchor.constraint(equalTo: secretWordtextField.bottomAnchor, constant: 16),
            checkGuessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            secretWordLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 16),
            secretWordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secretWordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            secretWordLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        checkGuessButton.target = {
            self.checkGuessButtonTap()
        }
        layout()
        self.button1.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        self.button2.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        self.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
    }
    
    @objc
    func handleButtonTap() {
        coordinator?.showPost()
    }

    @objc
    func checkGuessButtonTap() {
        if (feedModel.check(word: secretWordtextField.text!) == true) {
            secretWordLabel.backgroundColor = .systemGreen
        } else {
            secretWordLabel.backgroundColor = .systemRed
            let alert = UIAlertController(title: "Неверное слово!", message: "Введите верное слово", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Так точно", style: .default, handler: { action in print("ввести корректное слово") }))
            self.present(alert, animated: true)
        }
    }

}
