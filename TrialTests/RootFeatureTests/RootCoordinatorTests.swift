//
//  RootCoordinatorTests.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import XCTest
import RxSwift
@testable import Trial

class RootCoordinatorTests: XCTestCase {
    var disposeBag = DisposeBag()
    
    func testCoordinatorIncrementsAppLaunchCount() {
        let incrementAppLaunchCountUseCase = MockIncrementAppLaunchCountUseCase()
        incrementAppLaunchCountUseCase.stub = Stub { _ in }
        
        Container.shared.incrementAppLaunchCountUseCase { incrementAppLaunchCountUseCase }
        
        let sut = Container.shared.rootCoordinator(.init(frame: .zero))
        sut.start().subscribe().disposed(by: disposeBag)
        
        XCTAssertEqual(incrementAppLaunchCountUseCase.stub.calls.count, 1)
    }
}

private class MockIncrementAppLaunchCountUseCase: IncrementAppLaunchCountUseCaseProtocol {
    var stub: Stub<Void, Void> = .failing()
    func callAsFunction() {
        stub(())
    }
}
