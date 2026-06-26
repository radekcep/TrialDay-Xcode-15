//
//  IncrementAppLaunchCountUseCaseTests.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import XCTest
@testable import Trial

class IncrementAppLaunchCountUseCaseTests: XCTestCase {
    func testIncrementingAppLaunch() {
        let keyValueStorage = MockKeyValueStorage()
        keyValueStorage.valueIntStub = .init { _ in 42 }
        keyValueStorage.setIntStub = Stub { _ in }
        
        Container.shared.keyValueStorage { keyValueStorage }
        
        let sut = Container.shared.incrementAppLaunchCountUseCase()
        sut.callAsFunction()
        
        XCTAssertEqual(keyValueStorage.setIntStub.calls.map(\.key), ["app_launch_count"])
        XCTAssertEqual(keyValueStorage.setIntStub.calls.map(\.value), [43])
    }
}
