//
//  LoginInspector.swift
//  Navigation
//
//  Created by Андрей Васильев on 25.10.2022.
//

import Foundation
import UIKit

struct LoginInspector: LoginViewControllerDelegate {

    func checkCredentials(email: String, password: String, completion: ((_ alert: UIAlertController, _ authResult: Bool) -> Void)?) {
        CheckerService().checkCredentials(email: email, password: password, completion: completion)
    }

//    func signUp(email: String, password: String) {
//        CheckerService().signUp(email: email, password: password)
//    }

    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}
