//
//  TransactionsViewModelTests.swift
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

class TransactionsViewModelTests: XCTestCase {
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: .zero, simulateProcessingDelay: false)
        disposeBag = DisposeBag()
        
        Container.shared.mainScheduler { [unowned self] in self.testScheduler }
    }
    
    func testViewModelLoadsTransactionsOnSubscription() {
        let getTransactionsUseCase = MockGetTransactionsUseCase()
        getTransactionsUseCase.stub = Stub { .just(.mock) }
        let viewStateObserver = testScheduler.createObserver(TransactionsViewModel.ViewState.self)
        
        Container.shared.getTransactionsUseCase { getTransactionsUseCase }
        
        let sut = TransactionsViewModel(inputFromView: .init(
            userClickedOnTransaction: .never(),
            userClickOnRetry: .never(),
            userRefreshed: .never()
        ))
        sut.outputToView.viewState
            .bind(to: viewStateObserver)
            .disposed(by: disposeBag)
        testScheduler.start()
        
        XCTAssertEqual(viewStateObserver.events, [
            .next(0, .loading),
            .next(0, .transactions(.expectedTransactionsForMock))
        ])
    }
    
    func testViewModelLoadsTransactionsOnRetry() {
        let getTransactionsUseCase = MockGetTransactionsUseCase()
        getTransactionsUseCase.stub = Stub { .just(.mock) }
        let viewStateObserver = testScheduler.createObserver(TransactionsViewModel.ViewState.self)
        let retrySignal = PublishSubject<Void>()
        
        Container.shared.getTransactionsUseCase { getTransactionsUseCase }
        
        let sut = TransactionsViewModel(inputFromView: .init(
            userClickedOnTransaction: .never(),
            userClickOnRetry: retrySignal,
            userRefreshed: .never()
        ))
        sut.outputToView.viewState
            .bind(to: viewStateObserver)
            .disposed(by: disposeBag)
        testScheduler.scheduleAt(5) { retrySignal.onNext(()) }
        testScheduler.start()
        
        XCTAssertEqual(viewStateObserver.events, [
            .next(0, .loading),
            .next(0, .transactions(.expectedTransactionsForMock)),
            .next(5, .loading),
            .next(5, .transactions(.expectedTransactionsForMock)),
        ])
    }
    
    func testViewModelLoadsTransactionsOnRefresh() {
        let getTransactionsUseCase = MockGetTransactionsUseCase()
        getTransactionsUseCase.stub = Stub { .just(.mock) }
        let viewStateObserver = testScheduler.createObserver(TransactionsViewModel.ViewState.self)
        let refreshSignal = PublishSubject<Void>()
        
        Container.shared.getTransactionsUseCase { getTransactionsUseCase }
        
        let sut = TransactionsViewModel(inputFromView: .init(
            userClickedOnTransaction: .never(),
            userClickOnRetry: .never(),
            userRefreshed: refreshSignal
        ))
        sut.outputToView.viewState
            .bind(to: viewStateObserver)
            .disposed(by: disposeBag)
        testScheduler.scheduleAt(5) { refreshSignal.onNext(()) }
        testScheduler.start()
        
        XCTAssertEqual(viewStateObserver.events, [
            .next(0, .loading),
            .next(0, .transactions(.expectedTransactionsForMock)),
            .next(5, .loading),
            .next(5, .transactions(.expectedTransactionsForMock)),
        ])
    }
    
    func testViewModelGoesToErrorStateOnTransactionsFailure() {
        let getTransactionsUseCase = MockGetTransactionsUseCase()
        let transactionsSignal = PublishSubject<[Transaction]>()
        getTransactionsUseCase.stub = Stub { transactionsSignal.asSingle() }
        let viewStateObserver = testScheduler.createObserver(TransactionsViewModel.ViewState.self)
        
        Container.shared.getTransactionsUseCase { getTransactionsUseCase }
        
        let sut = TransactionsViewModel(inputFromView: .init(
            userClickedOnTransaction: .never(),
            userClickOnRetry: .never(),
            userRefreshed: .never()
        ))
        sut.outputToView.viewState
            .bind(to: viewStateObserver)
            .disposed(by: disposeBag)
        testScheduler.scheduleAt(5) { transactionsSignal.onError(MockError()) }
        testScheduler.start()
        
        XCTAssertEqual(viewStateObserver.events, [
            .next(0, .loading),
            .next(5, .error("Oh no!")),
        ])
    }
    
    func testViewModelOpensTransactionOntap() {
        let getTransactionsUseCase = MockGetTransactionsUseCase()
        getTransactionsUseCase.stub = Stub { .just(.mock) }
        let userClickedOnTransaction = PublishSubject<Int>()
        let transactionIDObserver = testScheduler.createObserver(String.self)
        
        Container.shared.getTransactionsUseCase { getTransactionsUseCase }
        
        let sut = TransactionsViewModel(inputFromView: .init(
            userClickedOnTransaction: userClickedOnTransaction.asObservable(),
            userClickOnRetry: .never(),
            userRefreshed: .never()
        ))
        sut.outputToCoordinator.openTransaction.map(\.id)
            .bind(to: transactionIDObserver)
            .disposed(by: disposeBag)
        testScheduler.scheduleAt(5) { userClickedOnTransaction.onNext(2) }
        testScheduler.start()
        
        XCTAssertEqual(transactionIDObserver.events, [
            .next(5, "D3DEA17BAC954E01"),
        ])
    }
}

private extension TransactionsViewModel.ViewState.Transactions {
    static let expectedTransactionsForMock = Self(
        transactions: [
            .init(
                title: "MA 10 Wiener Kindergaerten",
                subtitle: "MA 10 Wiener Kindergaerten/Wilma Ri",
                lineItems: "MA 10 Wiener Kindergaerten/Wilma Rinner/Elternbeitraege Wiener Kindergaert/PDezember 2017 V121282892",
                amount: "-65,35",
                isNegative: true
            ),
            .init(
                title: "DM-FIL. 0609",
                subtitle: "Payment with card 1 on the 10. Feb. at 17:38.",
                lineItems: nil,
                amount: "-15,55",
                isNegative: true
            ),
            .init(
                title: "HOFER DANKT",
                subtitle: "Payment with card 2 on the 10. Feb. at 12:18.",
                lineItems: nil,
                amount: "-15,92",
                isNegative: true
            ),
            .init(
                title: "SPAR DANKT 4249 WIEN",
                subtitle: "Payment with card 2 on the 9. Feb. at 15:18.",
                lineItems: nil,
                amount: "-18,09",
                isNegative: true
            ),
            .init(
                title: "Birgit Mayer",
                subtitle: "Miete Februar",
                lineItems: nil,
                amount: "435,00",
                isNegative: false
            )
        ],
        totalAmount: "320,09",
        isNegative: false
    )
}

private struct MockError: LocalizedError {
    var errorDescription: String? { "Oh no!" }
}

private class MockGetTransactionsUseCase: GetTransactionsUseCaseProtocol {
    var stub: Stub<Void, Single<[Transaction]>> = .failing()
    func callAsFunction() -> Single<[Transaction]> {
        stub(())
    }
}
