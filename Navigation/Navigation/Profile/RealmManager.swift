//
//  RealmManager.swift
//  Navigation
//
//  Created by Андрей Васильев on 26.12.2022.
//

import Foundation
import RealmSwift



class RealmManager {

    var realm: Realm!

    var authentications: [Authentication?] = []

    init() {

        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
        reloadData()
    }

    func reloadData() {
        authentications = Array(realm.objects(Authentication.self))
    }

    func signUp(email: String, password: String) {
        try! realm.write {
            let authentication = Authentication(email: email, password: password)
            realm.add(authentication)
        }
        reloadData()
    }

    func exit(authentication: Authentication) {
        try! realm.write {
            realm.delete(authentication)
        }
        reloadData()
    }

}
