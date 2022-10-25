//
//  UserService.swift
//  Navigation
//
//  Created by Андрей Васильев on 25.10.2022.
//

import Foundation

protocol UserService {
    func userService(login: String) -> User?
}
