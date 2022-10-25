//
//  TestUserService.swift
//  Navigation
//
//  Created by Андрей Васильев on 25.10.2022.
//

import Foundation

class TestUserService: UserService {
    let user: User
    init(user: User){
        self.user = user
    }
    func userService(login: String) -> User? {
        return login == user.login ? user : nil
    }
}
