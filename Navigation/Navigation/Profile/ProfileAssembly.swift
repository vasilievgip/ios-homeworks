//
//  ProfileAssembly.swift
//  Navigation
//
//  Created by Андрей Васильев on 13.11.2022.
//

import Foundation
import UIKit
import StorageService


let posts = Post.makeMockModel()

#if DEBUG
let user = User(login: "test@yandex.ru", fullName: "Test Test Test", avatar: UIImage(systemName: "eyes") ?? UIImage(named: "nophoto")!, status: "Waiting for Test...")
#else
let user = User(login: "vasilievgip@yandex.ru", fullName: "Андрей Александрович Васильев", avatar: UIImage(named: "avatar") ?? UIImage(named: "nophoto")!, status: "Waiting for something...")
#endif
