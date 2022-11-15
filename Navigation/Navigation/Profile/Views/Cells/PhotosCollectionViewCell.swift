//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Андрей Васильев on 03.08.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    private let photosImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.toAutoLayout()
        image.backgroundColor = .black
        return image
    }()

    private func layout() {
        contentView.addSubviews(photosImage)
        NSLayoutConstraint.activate([
            photosImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photosImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photosImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPhotosCell(model: User.PhotosArray) {
        photosImage.image = model.image
    }
}
