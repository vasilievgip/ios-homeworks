//
//  ProfileAssembly.swift
//  Navigation
//
//  Created by Андрей Васильев on 13.11.2022.
//

import Foundation
import UIKit


let postArray: [User.Post] = [
    User.Post(author: NSLocalizedString("author1PostArrayProfileAssembly", comment: ""), description: NSLocalizedString("description1PostArrayProfileAssembly", comment: ""), image: UIImage(named: "programmerday") ?? UIImage(named: "nophoto")!, likes: 10, views: 47687),
    User.Post(author: NSLocalizedString("author2PostArrayProfileAssembly", comment: ""), description: NSLocalizedString("description2PostArrayProfileAssembly", comment: ""), image: UIImage(named: "ozero") ?? UIImage(named: "nophoto")!, likes: 0, views: 58243),
    User.Post(author: NSLocalizedString("author2PostArrayProfileAssembly", comment: ""), description: NSLocalizedString("description3PostArrayProfileAssembly", comment: ""), image: UIImage(named: "walker") ?? UIImage(named: "nophoto")!, likes: 121, views: 4767787),
    User.Post(author: NSLocalizedString("author2PostArrayProfileAssembly", comment: ""), description: NSLocalizedString("description4PostArrayProfileAssembly", comment: ""), image: UIImage(named: "people") ?? UIImage(named: "nophoto")!, likes: 58561, views: 5353443),
    User.Post(author: NSLocalizedString("author2PostArrayProfileAssembly", comment: ""), description: NSLocalizedString("description5PostArrayProfileAssembly", comment: ""), image: UIImage(named: "monk") ?? UIImage(named: "nophoto")!, likes: 75865, views: 458243)
]

var photosArray: [User.PhotosArray] = [
    User.PhotosArray(image: UIImage(named: "photo1") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo2") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo3") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo4") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo5") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo6") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo7") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo8") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo9") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo10") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo11") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo12") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo13") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo14") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo15") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo16") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo17") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo18") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo19") ?? UIImage(named: "nophoto")!),
    User.PhotosArray(image: UIImage(named: "photo20") ?? UIImage(named: "nophoto")!)
]

#if DEBUG
let user = User(login: "vasilievgip@yandex.ru", fullName: NSLocalizedString("fullNameUserPostArrayProfileAssembly", comment: ""), avatar: UIImage(named: "avatar") ?? UIImage(named: "nophoto")!, status: NSLocalizedString("statusNameUserPostArrayProfileAssembly", comment: ""))
#else
let user = User(login: "test@yandex.ru", fullName: "Test Test Test", avatar: UIImage(systemName: "eyes") ?? UIImage(named: "nophoto")!, status: "Waiting for Test...")
#endif

var filterPhotosArray = [User.PhotosArray]()
