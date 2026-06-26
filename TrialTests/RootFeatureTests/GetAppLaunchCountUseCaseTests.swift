//
//  GetAppLaunchCountUseCaseTests.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import XCTest
@testable import Trial

class GetAppLaunchCountUseCaseTests: XCTestCase {
    func testGettingAppLaunch() {
        let keyValueStorage = MockKeyValueStorage()
        keyValueStorage.valueIntStub = .init { _ in 42 }
        
        Container.shared.keyValueStorage { keyValueStorage }
        
        let sut = Container.shared.getAppLaunchCountUseCase()
        let appLaunchCount = sut.callAsFunction()
        
        XCTAssertEqual(appLaunchCount, 42)
    }
}
