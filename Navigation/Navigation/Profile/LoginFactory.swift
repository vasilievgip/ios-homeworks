//
//  File.swift
//  Navigation
//
//  Created by Андрей Васильев on 25.10.2022.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
