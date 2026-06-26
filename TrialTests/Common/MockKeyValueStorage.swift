//
//  MockKeyValueStorage.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

@testable import Trial

class MockKeyValueStorage: KeyValueStorageProtocol {
    var setIntStub: Stub<(value: Int, key: String), Void> = .failing()
    func set(value: Int, forKey key: String) {
        setIntStub((value, key))
    }
    
    var valueIntStub: Stub<String, Int?> = .failing()
    func value(forKey key: String) -> Int? {
        valueIntStub(key)
    }
}
