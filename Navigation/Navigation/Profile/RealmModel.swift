//
//  RealmModel.swift
//  Navigation
//
//  Created by Андрей Васильев on 26.12.2022.
//

import Foundation
import RealmSwift


class Authentication: Object {

    @Persisted(primaryKey: true) var _id: ObjectId

    @Persisted var email: String
    @Persisted var password: String
    
    convenience init(email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }

}
