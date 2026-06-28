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
    private let totalAmountLabel = UILabel()
    private let refreshControl = UIRefreshControl()
    private let tableView = UITableView()
    private let errorView = ErrorView(frame: .zero)
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
            make.edges.equalToSuperview()
        }
    }
    
    func setupSubviews() {
        title = "Transactions"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: totalAmountLabel)
        if #available(iOS 26.0, *) {
            navigationItem.rightBarButtonItem?.hidesSharedBackground = true
        }
        
        tableView.refreshControl = refreshControl
        tableView.register(TransactionCell.self, forCellReuseIdentifier: Constant.transactionCellIdentifier)
        
        tableView.rx.itemSelected
            .bind(with: self) {
                $0.tableView.deselectRow(at: $1, animated: true)
            }
            .disposed(by: disposeBag)
        
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
            .subscribe(onNext: {
                $0.0.totalAmountLabel.text = $0.1
                $0.0.totalAmountLabel.sizeToFit()
            })
            .disposed(by: disposeBag)
        
        viewModel.outputToView.viewState
            .map(\.isLoading)
            .bind(to: refreshControl.rx.isRefreshing)
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
            override var outputToView: TransactionsViewModel.OutputToView {
                .init(viewState: .just(.error("Oh no!")))
            }
        }
        let viewController = TransactionsViewController()
        viewController.bind(viewModel: MockViewModel(inputFromView: viewController.viewModelInput))
        return UINavigationController(rootViewController: viewController)
    }
    
    return makeViewController()
}
