//
//  User.swift
//  Navigation
//
//  Created by Андрей Васильев on 16.10.2022.
//

import Foundation
import UIKit

class User {
    var login: String
    var fullName: String
    var avatar: UIImage
    var status: String
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
let user = User(login: "vasilievgip@yandex.ru", fullName: "Андрей Александрович Васильев", avatar: UIImage(named: "avatar") ?? UIImage(named: "nophoto")!, status: "Waiting for something...")
let testUser = User(login: "test@yandex.ru", fullName: "Test Test Test", avatar: UIImage(systemName: "eyes") ?? UIImage(named: "nophoto")!, status: "Waiting for Test...")
protocol UserService {
    func userService(login: String) -> User?
}
class CurrentUserService: UserService {
    let user: User
    init(user: User){
        self.user = user
    }
    func userService(login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
}
class TestUserService: UserService {
    let user: User
    init(user: User){
        self.user = user
    }
    func userService(login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
}
