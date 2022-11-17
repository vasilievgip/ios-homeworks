//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 03.08.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    weak var coordinator: LoginCoordinator?

//    let imagePublisherFacade = ImagePublisherFacade()

    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.toAutoLayout()
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collectionView
    }()

    private func layout() {
        view.addSubviews(photosCollectionView)
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func processImagesOnThread() {
        var photosUIImageArray = [UIImage]()
        var photosCGImageArray = [CGImage]()
        for image in photosArray {
            photosUIImageArray.append(image.image)
        }
        let startTime = DispatchTime.now()
        ImageProcessor().processImagesOnThread(sourceImages: photosUIImageArray,
                                               filter: .tonal,
                                               qos: .userInteractive) {
        photosCGImageArray = $0 as! [CGImage]
        photosUIImageArray.removeAll()
        for imageCGImage in photosCGImageArray {
            photosUIImageArray.append(UIImage(cgImage: imageCGImage))
        }
        photosArray.removeAll()
        for imageUIImage in photosUIImageArray {
            photosArray.append(User.PhotosArray(image: imageUIImage))
        }
    }
        let endTime = DispatchTime.now()
        let nanoTime = endTime.rawValue - startTime.rawValue
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("\(timeInterval) секунд")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        processImagesOnThread()
        layout()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
//        imagePublisherFacade.subscribe(self)
//        imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 10)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = true
//        imagePublisherFacade.removeSubscription(for: self)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    private var sideInset: CGFloat {return 8}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 4) / 3
        let height = width
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
}

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ProfileViewModel(user: user).photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupPhotosCell(model: ProfileViewModel(user: user).photos[indexPath.row])
        return cell
    }
}

//extension PhotosViewController: ImageLibrarySubscriber {
//    func receive(images: [UIImage]) {
//        for image in images {
//            let receiveImage = User.PhotosArray(image: image)
//            photosArray.append(receiveImage)
//            photosCollectionView.reloadData()
//        }
//    }
//}
