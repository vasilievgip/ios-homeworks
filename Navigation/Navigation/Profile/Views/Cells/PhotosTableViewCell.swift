//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Андрей Васильев on 27.07.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private let contentPhotosView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.createColor(lightMode: viewColorLight, darkMode: viewColorDark)
        view.toAutoLayout()
        return view
    }()

    private let photosLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("photosLabelPhotosTableViewCell", comment: "")
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 1
        label.toAutoLayout()
        return label
    }()

    private let photosButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrow.right.square"), for: .normal)
        button.toAutoLayout()
        return button
    }()

    private let photoImage1: UIImageView = {
        let image = UIImageView(image: UIImage(named: "photo1"))
        image.layer.cornerRadius = 6
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()

    private let photoImage2: UIImageView = {
        let image = UIImageView(image: UIImage(named: "photo2"))
        image.layer.cornerRadius = 6
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()

    private let photoImage3: UIImageView = {
        let image = UIImageView(image: UIImage(named: "photo3"))
        image.layer.cornerRadius = 6
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()

    private let photoImage4: UIImageView = {
        let image = UIImageView(image: UIImage(named: "photo4"))
        image.layer.cornerRadius = 6
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()

    private func layout() {
        contentView.addSubview(contentPhotosView)
        contentPhotosView.addSubviews(photosLabel, photosButton, photoImage1, photoImage2, photoImage3, photoImage4)
        NSLayoutConstraint.activate([
            contentPhotosView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentPhotosView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentPhotosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentPhotosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosLabel.topAnchor.constraint(equalTo: contentPhotosView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentPhotosView.leadingAnchor, constant: 12),
            photosButton.trailingAnchor.constraint(equalTo: contentPhotosView.trailingAnchor, constant: -12),
            photosButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            photoImage1.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            photoImage1.leadingAnchor.constraint(equalTo: contentPhotosView.leadingAnchor, constant: 12),
            photoImage1.bottomAnchor.constraint(equalTo: contentPhotosView.bottomAnchor, constant: -12),
            photoImage1.heightAnchor.constraint(equalTo: photoImage1.widthAnchor),
            photoImage2.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            photoImage2.leadingAnchor.constraint(equalTo: photoImage1.trailingAnchor, constant: 8),
            photoImage2.bottomAnchor.constraint(equalTo: contentPhotosView.bottomAnchor, constant: -12),
            photoImage2.widthAnchor.constraint(equalTo: photoImage1.widthAnchor),
            photoImage3.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            photoImage3.leadingAnchor.constraint(equalTo: photoImage2.trailingAnchor, constant: 8),
            photoImage3.bottomAnchor.constraint(equalTo: contentPhotosView.bottomAnchor, constant: -12),
            photoImage3.widthAnchor.constraint(equalTo: photoImage1.widthAnchor),
            photoImage4.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            photoImage4.leadingAnchor.constraint(equalTo: photoImage3.trailingAnchor, constant: 8),
            photoImage4.bottomAnchor.constraint(equalTo: contentPhotosView.bottomAnchor, constant: -12),
            photoImage4.widthAnchor.constraint(equalTo: photoImage1.widthAnchor),
            photoImage4.trailingAnchor.constraint(equalTo: contentPhotosView.trailingAnchor, constant: -12)
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
