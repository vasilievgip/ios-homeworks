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

        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
        }
        var config = Realm.Configuration(encryptionKey: key)
        config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        do {
            try realm = Realm()
        } catch {
            print(error)
        }
        
        reloadData()
    }

    func reloadData() {
        authentications = Array(realm.objects(Authentication.self))
    }

    func signUp(email: String, password: String) {
        do {
            try realm.write {
                let authentication = Authentication(email: email, password: password)
                realm.add(authentication)
            }
        } catch {
            print(error)
        }
        reloadData()
    }

    func exit(authentication: Authentication) {
        do {
            try realm.write {
                realm.delete(authentication)
            }
        } catch {
            print(error)
        }
        reloadData()
    }

}
