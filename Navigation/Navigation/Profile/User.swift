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
        return login == user.login ? user : nil
    }
}
class TestUserService: UserService {
    let user: User
    init(user: User){
        self.user = user
    }
    func userService(login: String) -> User? {
        return login == user.login ? user : nil
    }
}
class Checker {
    static let shared = Checker()
    private let login: String
    private let password: String
    private init() {
        login = "vasilievgip@yandex.ru"
        password = "12345"
    }
    func check(login: String, password: String) -> Bool {
        let enterLogin = login
        let enterPassword = password
        if enterLogin == Checker.shared.login,
           enterPassword == Checker.shared.password {
            return true
        } else {
            return false
        }
    }
}
protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}
struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}
protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        let loginInspector = LoginInspector()
        return loginInspector
    }
}
