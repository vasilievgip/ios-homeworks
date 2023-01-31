//
//  InfoViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 02.05.2022.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate {

    weak var coordinator: PostCoordinator?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NameResidentsTableViewCell.self, forCellReuseIdentifier: NameResidentsTableViewCell.identifier)
        return tableView
    }()

    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("deleteButtonInfoViewController", comment: ""), for: .normal)
        button.setTitleColor(UIColor.createColor(lightMode: .black, darkMode: .white), for: .normal)
        button.toAutoLayout()
        return button
    }()

    let jsonLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()

    let planetLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()

    func layout() {
        view.addSubviews(deleteButton, jsonLabel, planetLabel, tableView)
        NSLayoutConstraint.activate ([
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            deleteButton.heightAnchor.constraint(equalToConstant: 100),
            deleteButton.widthAnchor.constraint(equalToConstant: 200),
            jsonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            jsonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            jsonLabel.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 100),
            planetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            planetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            planetLabel.topAnchor.constraint(equalTo: jsonLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: planetLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        jsonRequest(comletion: { title in
            DispatchQueue.main.async {
                self.jsonLabel.text = title
            }
        })
        planetRequest(completion: { planet in
            DispatchQueue.main.async {
                self.planetLabel.text = planet?.orbitalPeriod
                residentsRequest(planet!, comletion: { resident in
                    DispatchQueue.main.async {
                        arrayNameResident = resident!
                        self.tableView.reloadData()
                    }
                })
                
            }
        })

        layout()
        self.deleteButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    @objc
    func handleButtonTap() {
        let alert = UIAlertController(title: NSLocalizedString("title1HandleButtonTapInfoViewController", comment: ""), message: NSLocalizedString("messageHandleButtonTapInfoViewController", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("title2HandleButtonTapInfoViewController", comment: ""), style: .default, handler: { action in }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("title3HandleButtonTapInfoViewController", comment: ""), style: .cancel, handler: { action in }))
        self.present(alert, animated: true)
    }

}

extension InfoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayNameResident.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NameResidentsTableViewCell.self), for: indexPath) as! NameResidentsTableViewCell
        cell.setupCell(model: arrayNameResident[indexPath.row])
        return cell
    }

}
