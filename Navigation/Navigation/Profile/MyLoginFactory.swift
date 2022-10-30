//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Андрей Васильев on 25.10.2022.
//

import Foundation

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        let loginInspector = LoginInspector()
        return loginInspector
    }
}
