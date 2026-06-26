//
//  KeyValueStorage.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import Foundation

protocol KeyValueStorageProtocol {
    func set(value: Int, forKey key: String)
    func value(forKey key: String) -> Int?
}

class KeyValueStorage: KeyValueStorageProtocol {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func set(value: Int, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func value(forKey key: String) -> Int? {
        userDefaults.value(forKey: key) as? Int
    }
}

extension Container {
    var keyValueStorage: Factory<KeyValueStorageProtocol> {
        self { KeyValueStorage(userDefaults: .standard) }
    }
}
