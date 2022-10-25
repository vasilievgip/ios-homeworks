//
//  LoginInspector.swift
//  Navigation
//
//  Created by Андрей Васильев on 25.10.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}
