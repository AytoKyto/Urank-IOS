//
//  KeychainManager.swift
//  Ranking
//
//  Created by Mathis Fleury on 30/12/2023.
//

import Foundation
import Security

class KeychainManager {
    static func save(_ value: String, forKey key: String) {
        let valueData = Data(value.utf8)

        // Création d'un dictionnaire pour la requête Keychain
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecValueData as String: valueData]

        // Supprimer toute ancienne valeur
        SecItemDelete(query as CFDictionary)

        // Ajouter la nouvelle valeur au Keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { return }
    }

    static func get(forKey key: String) -> String? {
        // Création d'un dictionnaire pour la requête Keychain
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecReturnData as String: kCFBooleanTrue!,
                                    kSecMatchLimit as String: kSecMatchLimitOne]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else { return nil }
        guard let data = item as? Data else { return nil }

        return String(data: data, encoding: .utf8)
    }
}
