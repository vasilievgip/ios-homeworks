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
        login = "1"
        password = "1"
    }
    func check(login: String, password: String) -> Bool {
        self.login == login && self.password == password
    }
}
