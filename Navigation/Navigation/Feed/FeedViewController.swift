//
//  ViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 10.04.2022.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate {

    weak var coordinator: MainFeedCoordinator?

    let feedModel = FeedModel()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Лента"
        label.toAutoLayout()
//        label.frame = CGRect(x: 170, y: 50, width: 100, height: 100)
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

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedViewCell.self, forCellReuseIdentifier: FeedViewCell.identifier)
        return tableView
    }()

    private let navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.toAutoLayout()
        return bar
    }()

    private let navigationBarButton_1: UIButton = {
        let button = UIButton()
        button.setTitle("Создать папку", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.toAutoLayout()
        return button
    }()

    private let navigationBarButton_2: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить фотографию", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.toAutoLayout()
        return button
    }()

    private func layout() {
        [button1, button2].forEach{ stackView.addArrangedSubview($0)}
        navigationBar.addSubviews(navigationBarButton_1, navigationBarButton_2)
        view.addSubviews(label, navigationBar, stackView, secretWordtextField, checkGuessButton, secretWordLabel, tableView)
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBarButton_1.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 16),
            navigationBarButton_1.trailingAnchor.constraint(equalTo: navigationBar.centerXAnchor, constant: -16),
            navigationBarButton_1.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            navigationBarButton_2.leadingAnchor.constraint(equalTo: navigationBar.centerXAnchor, constant: 16),
            navigationBarButton_2.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -16),
            navigationBarButton_2.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 100),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
        self.navigationBarButton_1.addTarget(self, action: #selector(createAfolder), for: .touchUpInside)
        self.navigationBarButton_2.addTarget(self, action: #selector(addAphoto), for: .touchUpInside)
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

    @objc
    func createAfolder() {

        let alert = UIAlertController(title: "Создать папку", message: "Введите название папки", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter text"
        }
        alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: { action in
            let newDirectoryPath = FileFolder.fileFolder.path + "/" + (alert.textFields?[0].text)!.uppercased()
            try? FileManager.default.createDirectory(atPath: newDirectoryPath, withIntermediateDirectories: false)
            self.tableView.reloadData()
            print("создать папку")
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { action in
            print("отмена")
        }))
        self.present(alert, animated: true)

    }

    @objc
    func addAphoto() {

        ImagePicker.defaultPicker.showPicker(in: self) { text in
            let urlImage = Bundle.main.url(forResource: text, withExtension: "jpg")
            if #available(iOS 16.0, *) {
                let  urlDestination = URL(filePath: FileFolder.fileFolder.path + "/" + text + ".jpg")
                try? FileManager.default.copyItem(at: urlImage!, to: urlDestination)
                self.tableView.reloadData()
            } else {
                print("Fallback on earlier versions")
            }
        }

    }

}

extension FeedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        FileFolder().files.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedViewCell.self), for: indexPath) as! FeedViewCell
        cell.setupCell(model: FileFolder.fileFolder.files[indexPath.row])
        return cell

    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fullPath = FileFolder.fileFolder.path + "/" + FileFolder.fileFolder.files[indexPath.row]
            try? FileManager.default.removeItem(atPath: fullPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
