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
        label.text = "labelFeedViewController".localized
        label.frame = CGRect(x: 170, y: 50, width: 100, height: 100)
        return label
    }()

    private let secretWordtextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .systemGray6
        field.placeholder = NSLocalizedString("secretWordtextFieldViewController", comment: "")
        field.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
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

    private let checkGuessButton = CustomButton(title: NSLocalizedString("checkGuessButtonFieldViewController", comment: ""),
                                                titleColor: .white,
                                                backgroundColor: UIColor(named: "Color_IOS20"),
                                                cornerRadius: 10)

    private  let secretWordLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.toAutoLayout()
        return label
    }()

    private let button1: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("button1FieldViewController", comment: ""), for: .normal)
        button.setTitleColor(UIColor.createColor(lightMode: .black, darkMode: .white), for: .normal)
        return button
    }()

    private let button2: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("button2FieldViewController", comment: ""), for: .normal)
        button.setTitleColor(UIColor.createColor(lightMode: .black, darkMode: .white), for: .normal)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.toAutoLayout()
        return stackView
    }()

    private let mapButton = CustomButton(title: NSLocalizedString("mapButtonFieldViewController", comment: ""),
                                         titleColor: .white,
                                         backgroundColor: UIColor(named: "Color_IOS20"),
                                         cornerRadius: 10)

    private func layout() {
        [button1, button2].forEach{ stackView.addArrangedSubview($0)}
        view.addSubviews(label, stackView, secretWordtextField, checkGuessButton, secretWordLabel, mapButton)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mapButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            mapButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            mapButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            mapButton.heightAnchor.constraint(equalToConstant: 50),
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
        mapButton.target = {
            self.mapTap()
        }
        layout()
        self.button1.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        self.button2.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        self.tabBarItem = UITabBarItem(title: NSLocalizedString("tabBarFieldViewController", comment: ""), image: UIImage(systemName: "house.fill"), tag: 0)
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
            let alert = UIAlertController(title: NSLocalizedString("title1CheckGuessButtonTapFieldViewControlle", comment: ""), message: NSLocalizedString("messageCheckGuessButtonTapFieldViewControlle", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("title2CheckGuessButtonTapFieldViewControlle", comment: ""), style: .default, handler: { action in }))
            self.present(alert, animated: true)
        }
    }

    @objc
    func mapTap() {
        if #available(iOS 16.0, *) {
            let vc = MapViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
        }
    }
    
}
