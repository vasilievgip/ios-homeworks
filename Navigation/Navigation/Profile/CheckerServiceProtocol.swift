//
//  CheckerServiceProtocol.swift
//  Navigation
//
//  Created by Андрей Васильев on 12.12.2022.
//

import Foundation
import UIKit

protocol CheckerServiceProtocol {

    func checkCredentials(email: String, password: String, completion: ((_ alert: UIAlertController, _ authResult: Bool) -> Void)?)

    func signUp(email: String, password: String)
    
}
