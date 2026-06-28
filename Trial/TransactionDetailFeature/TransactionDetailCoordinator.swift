//
//  TransactionDetailCoordinator.swift
//  Trial
//
//  Created by Radek on 28.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import UIKit
import RxSwift

protocol TransactionDetailCoordinatorProtocol: Coordinator {}

class TransactionDetailCoordinator: TransactionDetailCoordinatorProtocol {
    let navigationController: UINavigationController
    let transaction: Transaction
    
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController, transaction: Transaction) {
        self.navigationController = navigationController
        self.transaction = transaction
    }
    
    func start() -> Single<Void> {
        let transactionDetailViewController = Container.shared.transactionDetailViewController()
        let transactionDetailViewModel = Container.shared.transactionDetailViewModel((
            transactionDetailViewController.viewModelInput,
            .init(transaction: transaction)
        ))
        transactionDetailViewController.bind(viewModel: transactionDetailViewModel)
        
        navigationController.pushViewController(transactionDetailViewController, animated: true)
        
        return transactionDetailViewModel
            .outputToCoordinator
            .viewIsMovingFromParent
            .take(1)
            .asSingle()
    }
}

extension Container {
    var transactionDetailCoordinator: ParameterFactory<(UINavigationController, Transaction), TransactionDetailCoordinatorProtocol> {
        self(TransactionDetailCoordinator.init)
    }
}
