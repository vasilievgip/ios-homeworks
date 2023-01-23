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
                let alert = UIAlertController(title: NSLocalizedString("title1CheckCredentialsCheckerService", comment: ""), message: NSLocalizedString("messageCheckCredentialsCheckerService", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("title2CheckCredentialsCheckerService", comment: ""), style: .default, handler: { action in }))
                alert.addAction(UIAlertAction(title: NSLocalizedString("title3CheckCredentialsCheckerService", comment: ""), style: .default, handler: { action in
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
