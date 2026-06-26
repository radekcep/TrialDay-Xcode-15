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
    
    func testCoordinatorLaunchesSplashWhenCountIsOne() {
        let incrementAppLaunchCountUseCase = MockIncrementAppLaunchCountUseCase()
        incrementAppLaunchCountUseCase.stub = Stub { _ in }
        let getAppLaunchCountUseCase = MockGetAppLaunchCountUseCase()
        getAppLaunchCountUseCase.stub = Stub { 1 }
        let splashCoordinator = MockSplashScreenCoordinator()
        splashCoordinator.startStub = Stub { .never() }
        let splashCoordinatorStub = Stub { (_: UIViewController) in splashCoordinator }
        
        Container.shared.incrementAppLaunchCountUseCase { incrementAppLaunchCountUseCase }
        Container.shared.getAppLaunchCountUseCase { getAppLaunchCountUseCase }
        Container.shared.splashScreenCoordinator { splashCoordinatorStub($0) }
        
        let sut = Container.shared.rootCoordinator(.init(frame: .zero))
        sut.start().subscribe().disposed(by: disposeBag)
        
        XCTAssertEqual(splashCoordinatorStub.calls.count, 1)
        XCTAssertEqual(splashCoordinator.startStub.calls.count, 1)
    }
    
    func testCoordinatorDoesNotLaunchSplashWhenCountGreaterThanOne() {
        let incrementAppLaunchCountUseCase = MockIncrementAppLaunchCountUseCase()
        incrementAppLaunchCountUseCase.stub = Stub { _ in }
        let getAppLaunchCountUseCase = MockGetAppLaunchCountUseCase()
        getAppLaunchCountUseCase.stub = Stub { 2 }
        let splashCoordinator = MockSplashScreenCoordinator()
        let splashCoordinatorStub = Stub { (_: UIViewController) in splashCoordinator }
        
        Container.shared.incrementAppLaunchCountUseCase { incrementAppLaunchCountUseCase }
        Container.shared.getAppLaunchCountUseCase { getAppLaunchCountUseCase }
        Container.shared.splashScreenCoordinator { splashCoordinatorStub($0) }
        
        let sut = Container.shared.rootCoordinator(.init(frame: .zero))
        sut.start().subscribe().disposed(by: disposeBag)
        
        XCTAssertEqual(splashCoordinatorStub.calls.count, .zero)
        XCTAssertEqual(splashCoordinator.startStub.calls.count, .zero)
    }
}

private class MockGetAppLaunchCountUseCase: GetAppLaunchCountUseCaseProtocol {
    var stub: Stub<Void, Int> = .failing()
    func callAsFunction() -> Int {
        stub(())
    }
}

private class MockIncrementAppLaunchCountUseCase: IncrementAppLaunchCountUseCaseProtocol {
    var stub: Stub<Void, Void> = .failing()
    func callAsFunction() {
        stub(())
    }
}

private class MockSplashScreenCoordinator: SplashScreenCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    
    var startStub: Stub<Void, Single<Void>> = .failing()
    func start() -> Single<Void> {
        startStub(())
    }
}
