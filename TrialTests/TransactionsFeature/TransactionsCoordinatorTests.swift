//
//  TransactionsCoordinatorTests.swift
//  Trial
//
//  Created by Radek on 28.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import XCTest
import RxSwift
import RxTest
@testable import Trial

class TransactionsCoordinatorTests: XCTestCase {
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: .zero, simulateProcessingDelay: false)
        disposeBag = DisposeBag()
        
        Container.shared.mainScheduler { [unowned self] in self.testScheduler }
    }
    
    func testCoordinatorOpensTransactionDetail() {
        let openTransaction = PublishSubject<Transaction>()
        let transactionIDObserver = testScheduler.createObserver(String.self)
        
        Container.shared.transactionsViewModel {
            let transactionsViewModel = MockTransactionsViewModel(inputFromView: $0)
            transactionsViewModel.outputToCoordinatorStub = Stub { .init(openTransaction: openTransaction.asObservable()) }
            return transactionsViewModel
        }
        Container.shared.transactionDetailCoordinator { _, transaction in
            let transactionDetailCoordinator = MockTransactionDetailCoordinator()
            transactionDetailCoordinator.startStub = Stub { .never() }
            transactionIDObserver.onNext(transaction.id)
            return transactionDetailCoordinator
        }
        
        let sut = Container.shared.transactionsCoordinator(.init())
        sut.start().subscribe().disposed(by: disposeBag)
        testScheduler.scheduleAt(5) { openTransaction.onNext([Transaction].mock.first!) }
        testScheduler.start()
        
        XCTAssertEqual(transactionIDObserver.events, [
            .next(5, "D3E0BD0330B14C01")
        ])
    }
}

private class MockTransactionDetailCoordinator: TransactionDetailCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    
    var startStub: Stub<Void, Single<Void>> = .failing()
    func start() -> Single<Void> {
        startStub(())
    }
}

private class MockTransactionsViewModel: TransactionsViewModel {
    var outputToCoordinatorStub: Stub<Void, TransactionsViewModel.OutputToCoordinator> = .failing()
    override var outputToCoordinator: TransactionsViewModel.OutputToCoordinator {
        outputToCoordinatorStub(())
    }
}
