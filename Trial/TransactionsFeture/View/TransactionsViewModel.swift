//
//  TransactionsViewModel.swift
//  Trial
//
//  Created by Radek on 27.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import Foundation
import FactoryKit
import RxSwift

class TransactionsViewModel {
    fileprivate enum State {
        case loading
        case error(Error)
        case transactions([Transaction])
    }
    
    enum ViewState: Equatable {
        case loading
        case error(String)
        case transactions(Transactions)
    }
    
    struct InputFromView {
        let userClickedOnTransaction: Observable<Int>
        let userClickOnRetry: Observable<Void>
        let userRefreshed: Observable<Void>
    }

    struct OutputToView {
        let viewState: Observable<ViewState>
    }
    
    struct OutputToCoordinator {
        let openTransaction: Observable<Transaction>
    }
    
    @Injected(\.getTransactionsUseCase) var getTransactionsUseCase
    
    let inputFromView: InputFromView
     
    private lazy var state: Observable<State> = Observable.merge([
            .just(()),
            inputFromView.userClickOnRetry,
            inputFromView.userRefreshed,
        ])
        .withUnretained(self)
        .flatMapLatest { unretainedSelf, _ in
            Observable.just(.loading)
                .concat(
                    unretainedSelf.getTransactionsUseCase()
                        .map(State.transactions)
                        .catch { .just(.error($0)) }
                )
        }
        .share()
    
    private(set) lazy var outputToView = OutputToView(
        viewState: state
            .map(\.asViewState)
            .observe(on: Container.shared.mainScheduler())
    )
    
    private(set) lazy var outputToCoordinator = OutputToCoordinator(
        openTransaction: inputFromView
            .userClickedOnTransaction
            .withLatestFrom(state) {
                $1.transactions[$0]
            }
    )
    
    init(inputFromView: InputFromView) {
        self.inputFromView = inputFromView
    }
}

// MARK: - ViewState UI Model

extension TransactionsViewModel.ViewState {
    struct Transaction: Equatable {
        let title: String
        let subtitle: String?
        let lineItems: String?
        let amount: String?
    }
    
    struct Transactions: Equatable {
        let transactions: [Transaction]
        let totalAmount: String?
    }
    
    var transactions: [Transaction] {
        if case let .transactions(transactions) = self { transactions.transactions } else { [] }
    }
    
    var totalAmount: String? {
        if case let .transactions(transactions) = self { transactions.totalAmount } else { nil }
    }
    
    var isLoading: Bool {
        if case .loading = self { true } else { false }
    }
    
    var errorDescription: String? {
        if case .error(let errorDescription) = self { errorDescription } else { nil }
    }
}

private extension TransactionsViewModel.State {
    var asViewState: TransactionsViewModel.ViewState {
        switch self {
        case .loading:
            .loading
        case .error(let error):
            .error(error.localizedDescription)
        case .transactions(let transactions):
            .transactions(.init(
                transactions: transactions.viewStateTransactions,
                totalAmount: transactions.viewStateTotalAmount
            ))
        }
    }
    
    var transactions: [Transaction] {
        if case let .transactions(transactions) = self { transactions } else { [] }
    }
}

private extension [Transaction] {
    private static let amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var viewStateTransactions: [TransactionsViewModel.ViewState.Transaction] {
        map {
            var lineItems: Optional = $0.additionalTexts.lineItems.joined()
            lineItems = if lineItems?.isEmpty == true { nil } else { lineItems }
            
            return .init(
                title: $0.title,
                subtitle: $0.subtitle,
                lineItems: lineItems,
                amount: Self.amountFormatter.string(from: $0.amount.decimalValue)
            )
        }
    }
    
    var viewStateTotalAmount: String? {
        let totalAmount = map(\.amount.decimalValue)
            .reduce(NSDecimalNumber.zero) { $0.adding($1) }
        return Self.amountFormatter.string(from: totalAmount)
    }
}

extension Container {
    var transactionsViewModel: ParameterFactory<TransactionsViewModel.InputFromView, TransactionsViewModel> {
        self(TransactionsViewModel.init)
    }
}
