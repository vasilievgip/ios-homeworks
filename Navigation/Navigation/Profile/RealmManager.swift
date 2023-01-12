//
//  RealmManager.swift
//  Navigation
//
//  Created by Андрей Васильев on 26.12.2022.
//

import Foundation
import RealmSwift
import KeychainSwift



class RealmManager {

    var realm: Realm!

    var authentications: [Authentication?] = []

    init() {

        let config = Realm.Configuration(encryptionKey: getKey(), schemaVersion: 1)
        
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

    func getKey() -> Data {

        let keychainIdentifier = "io.Realm.EncryptionNavigationKey"

        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!

        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]

        var dataTypeRef: AnyObject?

        var status = withUnsafeMutablePointer(to: &dataTypeRef) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        if status == errSecSuccess {
            return dataTypeRef as! Data
        }

        var key = Data(count: 64)
        key.withUnsafeMutableBytes ({ (pointer: UnsafeMutableRawBufferPointer) in
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            assert(result == 0, "Failed to get random bytes")
        })

        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: key as AnyObject
        ]

        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")

        return key

    }

}
