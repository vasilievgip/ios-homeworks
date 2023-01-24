//
//  PostViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 01.05.2022.
//

import UIKit
import CoreData

class PostViewController: UIViewController, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    weak var coordinator: MainPostCoordinator?

    let fetchResultController: NSFetchedResultsController = {
        let fetchRequest = Post.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "likes", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.defaultManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()

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

        self.tabBarItem = UITabBarItem(title: NSLocalizedString("tabBarPostViewController", comment: ""), image: UIImage(systemName: "star.circle"), tag: 1)

        let filterBarButtonItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(title: NSLocalizedString("filterBarButtonItemPostViewController", comment: ""), style: .plain, target: self, action: #selector(filter))
            return barButtonItem
        }()
        let noFilterBarButtonItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(title: NSLocalizedString("noFilterBarButtonItemPostViewController", comment: ""), style: .plain, target: self, action: #selector(noFilter))
            return barButtonItem
        }()
        self.navigationItem.rightBarButtonItems = [noFilterBarButtonItem, filterBarButtonItem]

        layout()

        fetchResultController.delegate = self
        try? fetchResultController.performFetch()

    }

    @objc
    func filter() {
        let alert = UIAlertController(title: NSLocalizedString("title1FilterPostViewController", comment: ""), message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = NSLocalizedString("placeholderFilterPostViewController", comment: "") }
        alert.addAction(UIAlertAction(title: NSLocalizedString("title2FilterPostViewController", comment: ""), style: .default, handler: { action in
            if alert.textFields?[0].text != nil {
                CoreDataManager.defaultManager.filterPostAuthor(byAuthor: alert.textFields![0].text!)
                //                self.tableView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("title3FilterPostViewController", comment: ""), style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }

    @objc
    func noFilter() {
        CoreDataManager.defaultManager.noFilterPostAuthor()
    }

}

extension PostViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchResultController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        cell.setupInfoCell(model: fetchResultController.object(at: indexPath))
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = fetchResultController.object(at: indexPath)
            CoreDataManager.defaultManager.deletePost(post: post)
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }

}

