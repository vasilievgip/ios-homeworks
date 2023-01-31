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

    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()

    private func layout() {
        view.addSubviews(photosCollectionView, timerLabel)
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timerLabel.heightAnchor.constraint(equalToConstant: 50),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func filterTimer() {

        var seconds = 0.0

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            seconds += 0.1
            let number = NSString(format: "%.1f", seconds)
            self.timerLabel.text = NSLocalizedString("timerLabel1PhotosViewController", comment: "") + (number as String) + NSLocalizedString("timerLabel2PhotosViewController", comment: "")
            if filterPhotosArray.count != 0 {
                timer.invalidate()
                self.timerLabel.text = ""
            }
        }
    }

    private func processImagesOnThread() {

        let startTime = DispatchTime.now()

        var photosUIImageArray = [UIImage]()
        for image in photosArray {
            photosUIImageArray.append(image.image)
        }

        func transformation(cgImageArray: [CGImage]) -> [User.PhotosArray] {
            let images = cgImageArray.map {
                (cgImage) -> User.PhotosArray in
                User.PhotosArray(image: UIImage(cgImage: cgImage))
            }
            return images
        }

        ImageProcessor().processImagesOnThread(sourceImages: photosUIImageArray,
                                               filter: .bloom(intensity: 10),
                                               qos: .default) {

            let photosCGImageArray = $0 as! [CGImage]
            filterPhotosArray = transformation(cgImageArray: photosCGImageArray)

            DispatchQueue.main.async {
                self.photosCollectionView.reloadData()
            }

            let endTime = DispatchTime.now()
            let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
            _ = Double(nanoTime) / 1_000_000_000

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.createColor(lightMode: viewColorLight, darkMode: viewColorDark)
        processImagesOnThread()
        layout()
        filterTimer()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = NSLocalizedString("titlePhotosViewController", comment: "")
//        imagePublisherFacade.subscribe(self)
//        imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 10)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = true
//        coordinator?.didLogin()
        filterPhotosArray.removeAll()
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
