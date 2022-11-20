//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Андрей Васильев on 13.11.2022.
//

import Foundation
import UIKit


class ProfileViewModel {

    var photos: [User.PhotosArray] = filterPhotosArray

    var posts: [User.Post] = postArray

    var user: User

    init(user: User) {
        self.user = user
    }

    var login: String {
        return user.login
    }
    var fullName: String {
        return user.fullName
    }
    var avatar: UIImage {
        return user.avatar
    }
    var status: String {
        return user.status
    }

}
