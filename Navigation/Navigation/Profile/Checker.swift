//
//  Checker.swift
//  Navigation
//
//  Created by Андрей Васильев on 25.10.2022.
//

import Foundation

class Checker {
    static let shared = Checker()
    private let login: String
    private let password: String
    private init() {
        login = "vasilievgip@yandex.ru"
        password = "12345"
    }
    func check(login: String, password: String) -> Bool {
        self.login == login && self.password == password
    }
}
