//
//  User.swift
//  Navigation
//
//  Created by Андрей Васильев on 16.10.2022.
//

import Foundation
import UIKit

class User {
    
    struct Post {
        public var author: String
        public var description: String
        public var image: UIImage
        public var likes: Int64
        public var views: Int64
    }
    
    struct CurrentPost {
        public var author: String
        public var descr: String
        public var image: Data?
        public var likes: Int64
        public var views: Int64
    }
    
    struct PhotosArray {
        var image: UIImage
    }
    
    var login: String
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
    
}
