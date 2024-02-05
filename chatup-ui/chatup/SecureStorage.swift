//
//  SecureStorage.swift
//  chatup
//
//  Created by Nicholas Amaya on 2/4/24.
//

import Foundation

class SecureStorage {
    func storeUserCredentials(token: String) {
        let tag = "com.namaya.keys.userToken".data(using: .utf8)!
        let addquery: [String: Any] = [kSecClass as String: kSecClassKey, // indicates a key (rather than a certificate or password)
                                       kSecAttrApplicationTag as String: tag,
                                       kSecValueRef as String: token]
    
        let status = SecItemAdd(addquery as CFDictionary, nil)
        guard status == errSecSuccess else {
            print("Couldn't store user credentials in Keychain.")
            return
        }
        
        print("User credentials successfully stored in Keychain.")
    }
}
