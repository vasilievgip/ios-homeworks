//
//  PostViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 01.05.2022.
//

import UIKit

class PostViewController: UIViewController, UITableViewDelegate {

    weak var coordinator: MainPostCoordinator?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return tableView
    }()

    private func layout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        self.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "star.circle"), tag: 1)

        let filterBarButtonItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(title: "Фильтр", style: .plain, target: self, action: #selector(filter))
            return barButtonItem
        }()
        let noFilterBarButtonItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(noFilter))
            return barButtonItem
        }()
        self.navigationItem.rightBarButtonItems = [noFilterBarButtonItem, filterBarButtonItem]

        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc
    func filter() {
        let alert = UIAlertController(title: "Фильтр по автору", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter text" }
        alert.addAction(UIAlertAction(title: "Применить", style: .default, handler: { action in
            if alert.textFields?[0].text != nil {
                CoreDataManager.defaultManager.filterPostAuthor(byAuthor: alert.textFields![0].text!)
                self.tableView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "Отменить", style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }

    @objc
    func noFilter() {
        CoreDataManager.defaultManager.reloadPosts()
        self.tableView.reloadData()
    }

}

extension PostViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CoreDataManager.defaultManager.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        cell.setupInfoCell(model: CoreDataManager.defaultManager.posts[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = CoreDataManager.defaultManager.posts[indexPath.row]
            CoreDataManager.defaultManager.deletePost(post: post)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }

}

