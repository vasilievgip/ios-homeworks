//
//  CheckerService.swift
//  Navigation
//
//  Created by Андрей Васильев on 12.12.2022.
//

import Foundation
import FirebaseAuth
import UIKit


class CheckerService: CheckerServiceProtocol {

    weak var coordinator: MainProfileCoordinator?

    func checkCredentials(email: String, password: String, completion: ((_ alert: UIAlertController, _ authResult: Bool) -> Void)?) {

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print(error.localizedDescription)
                let alert = UIAlertController(title: "Неверный логин или пароль!", message: "Введите корректный логин или пароль", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ввести", style: .default, handler: { action in
                    print("ввести корректный логин или пароль")
                }))
                alert.addAction(UIAlertAction(title: "Зарегистрироваться", style: .default, handler: { action in
                    self.signUp(email: email, password: password)
                }))
                completion?(alert, false)
            } else {
                completion?(UIAlertController(), true)
            }
        }
        
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password)
    }

}
