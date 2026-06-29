//
//  TransactionsViewController.swift
//  Trial
//
//  Created by Radek on 27.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import UIKit
import RxCocoa
import RxSwift
import SnapKit

class TransactionsViewController: UIViewController {
    private let amountPillView = AmountPillView()
    private let refreshControl = UIRefreshControl()
    private let tableView = UITableView()
    private let errorView = ErrorView()
    private let viewIsAppearing = PublishSubject<Void>()
    private var viewModel: TransactionsViewModel!
    private var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        constraintSubviews()
        setupSubviews()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        viewIsAppearing.onNext(())
    }
}

// MARK: - UI Setup

private extension TransactionsViewController {
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(errorView)
    }
    
    func constraintSubviews() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        errorView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    func setupSubviews() {
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.title,
            .foregroundColor: UIColor(resource: .text)
        ]
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: amountPillView)
        if #available(iOS 26.0, *) {
            navigationItem.rightBarButtonItem?.hidesSharedBackground = true
        }
        
        title = "Transactions"
        view.backgroundColor = UIColor(resource: .background)
        
        tableView.backgroundColor = .clear
        tableView.refreshControl = refreshControl
        tableView.register(TransactionCell.self, forCellReuseIdentifier: Constant.transactionCellIdentifier)
        
        tableView.rx.itemSelected
            .bind(with: self) {
                $0.tableView.deselectRow(at: $1, animated: true)
            }
            .disposed(by: disposeBag)
        
        refreshControl.tintColor = UIColor(resource: .primary)
        refreshControl.tintColorDidChange()
        
        errorView.isHidden = true
    }
}

// MARK: - ViewModel Binding

extension TransactionsViewController {
    var viewModelInput: TransactionsViewModel.InputFromView {
        .init(
            userClickedOnTransaction: tableView.rx.itemSelected.map(\.row),
            userClickOnRetry: errorView.retryButtonTap,
            userRefreshed: refreshControl.rx.controlEvent(.valueChanged).map { _ in () }
        )
    }
    
    func bind(viewModel: TransactionsViewModel) {
        self.viewModel = viewModel
        
        viewModel.outputToView.viewState
            .map(\.totalAmount)
            .withUnretained(self)
            .subscribe(onNext: { unretainedSelf, totalAmount in
                if let totalAmount {
                    unretainedSelf.amountPillView.load(totalAmount.text, isNegative: totalAmount.isNegative)
                    unretainedSelf.amountPillView.sizeToFit()
                    unretainedSelf.amountPillView.isHidden = false
                } else {
                    unretainedSelf.amountPillView.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.outputToView.viewState
            .map(\.isLoading)
            .skip(until: viewIsAppearing)
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
                
        // `refreshControl` cannot be controlled before `viewIsAppearing` is called
        viewIsAppearing.take(1)
            .withLatestFrom(viewModel.outputToView.viewState)
            .filter { $0.isLoading }
            .withUnretained(self)
            .subscribe(onNext: { unretainedSelf, _ in
                unretainedSelf.tableView.contentOffset = CGPoint(x: 0, y: -unretainedSelf.refreshControl.frame.height)
                unretainedSelf.refreshControl.beginRefreshing()
            })
            .disposed(by: disposeBag)
        
        viewModel.outputToView.viewState
            .map(\.transactions)
            .bind(to: tableView.rx.items(
                cellIdentifier: Constant.transactionCellIdentifier,
                cellType: TransactionCell.self
            )) { _, transaction, cell in
                cell.load(transaction)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputToView.viewState
            .map(\.errorDescription)
            .withUnretained(errorView)
            .subscribe(onNext: { errorView, errorDescription in
                errorView.load(errorDescription)
                errorView.isHidden = errorDescription == nil
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - DI

extension Container {
    var transactionsViewController: Factory<TransactionsViewController> {
        self(TransactionsViewController.init)
    }
}

// MARK: - Constant

private enum Constant {
    static let transactionCellIdentifier = "TransactionCell"
}

// MARK: - Preview

@available(iOS 18, *)
#Preview {
    func makeViewController() -> UIViewController {
        class MockViewModel: TransactionsViewModel {
            let transaction = TransactionsViewModel.ViewState.Transaction(
                title: "MA 10 Wiener Kindergaerten",
                subtitle: Optional("MA 10 Wiener Kindergaerten/Wilma Ri"),
                lineItems: Optional("MA 10 Wiener Kindergaerten/Wilma Rinner/Elternbeitraege Wiener Kindergaert/PDezember 2017 V121282892"),
                amount: Optional("-65,35"),
                isNegative: true
            )
            lazy var transactions = Array(repeating: transaction, count: 5)
            
//            override var outputToView: TransactionsViewModel.OutputToView {
//                .init(viewState: .just(.transactions(.init(transactions: transactions, totalAmount: "-100,00", isNegative: true))))
//            }
            
            override var outputToView: TransactionsViewModel.OutputToView {
                .init(viewState: .just(.loading))
            }
        }
        
        let viewController = TransactionsViewController()
        _ = viewController.view
        viewController.bind(viewModel: MockViewModel(inputFromView: viewController.viewModelInput))
        return UINavigationController(rootViewController: viewController)
    }
    
    return makeViewController()
}
