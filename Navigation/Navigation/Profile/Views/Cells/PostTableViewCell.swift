//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Андрей Васильев on 27.06.2022.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {

    private let contentWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.toAutoLayout()
        return view
    }()

    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.toAutoLayout()
        return label
    }()

    let postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.toAutoLayout()
        return image
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()

    let likesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.toAutoLayout()
        return label
    }()

    let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        label.toAutoLayout()
        return label
    }()

    private func layout() {
        contentView.addSubview(contentWhiteView)
        contentView.backgroundColor = .gray
        contentWhiteView.addSubviews(authorLabel, postImage, descriptionLabel, likesLabel, viewsLabel)
        NSLayoutConstraint.activate([
            contentWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentWhiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentWhiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorLabel.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -16),
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            postImage.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -16),
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor, constant: 16),
            likesLabel.trailingAnchor.constraint(equalTo: contentWhiteView.centerXAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor),
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.leadingAnchor.constraint(equalTo: contentWhiteView.centerXAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor)
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(model: User.Post) {
        authorLabel.text = model.author
        postImage.image = model.image
        descriptionLabel.text = model.description
        likesLabel.text = "Likes: \(model.likes)"
        viewsLabel.text = "Views: \(model.views)"
    }

    func setupInfoCell(model: Post) {
        authorLabel.text = model.author
        postImage.image = UIImage(data: model.image!)
        descriptionLabel.text = model.descr
        likesLabel.text = "Likes: \(model.likes)"
        viewsLabel.text = "Views: \(model.views)"
    }

}
