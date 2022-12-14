//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Андрей Васильев on 25.10.2022.
//

import Foundation

protocol LoginViewControllerDelegate: CheckerServiceProtocol {

    func check(login: String, password: String) -> Bool
    
}
