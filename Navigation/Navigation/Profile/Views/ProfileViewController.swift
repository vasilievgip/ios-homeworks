//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 14.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    weak var coordinator: LoginCoordinator?

    static let defaultViewController = ProfileViewController()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
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
#if DEBUG
        view.backgroundColor = UIColor.createColor(lightMode: viewColorLight, darkMode: viewColorDark)
#else
        view.backgroundColor = .systemRed
#endif
        layout()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        coordinator?.didLogin()
    }

}

var currentPost = User.CurrentPost(author: String(), descr: String(), image: Data(), likes: Int64(), views: Int64())

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return ProfileViewModel(user: user).posts.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            cell.setupCell(model: ProfileViewModel(user: user).posts[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return ProfileHeaderView()
        }
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            coordinator?.viewPhotos()
        } else {
            let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
            tap.numberOfTapsRequired = 2
            view.addGestureRecognizer(tap)
            currentPost.author = ProfileViewModel(user: user).posts[indexPath.row].author
            currentPost.descr = ProfileViewModel(user: user).posts[indexPath.row].description
            currentPost.image = ProfileViewModel(user: user).posts[indexPath.row].image.pngData()
            currentPost.likes = ProfileViewModel(user: user).posts[indexPath.row].likes
            currentPost.views = ProfileViewModel(user: user).posts[indexPath.row].views
        }
    }

    @objc
    func doubleTapped() {
        CoreDataManager.defaultManager.addPost(post: currentPost)
    }

}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return UITableView.automaticDimension
        } else {
            return CGFloat.leastNonzeroMagnitude
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat.leastNonzeroMagnitude
    }
}

extension ProfileViewController: UITableViewDragDelegate, UITableViewDropDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = dragItem(indexPath: indexPath)
        return [dragItem]
    }

    private func dragItem(indexPath: IndexPath) -> UIDragItem {
        var itemProvider: NSItemProvider!
        if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
            itemProvider = NSItemProvider(object: cell.postImage.image! as NSItemProviderWriting)
        } else if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
            itemProvider = NSItemProvider(object: cell.descriptionLabel.text! as NSItemProviderWriting)
        }
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return dragItem
    }

    func tableView(_ tableView: UITableView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let dragItem = dragItem(indexPath: indexPath)
        return [dragItem]
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {

        let destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }

        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            let stringItems = items as! [String]
            addItems(stringItems)
        }

        coordinator.session.loadObjects(ofClass: UIImage.self) { items in
            let imageItems = items as! [UIImage]
            addItems(imageItems)
        }

        func addItems(_ items: [Any]) {
            for (index, item) in items.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                
            }
        }

    }

    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {

        return session.canLoadObjects(ofClass: NSString.self) || session.canLoadObjects(ofClass: UIImage.self)

    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {

        return UITableViewDropProposal(operation: .copy)

    }

}
