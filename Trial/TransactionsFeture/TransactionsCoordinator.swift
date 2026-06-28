//
//  TransactionsCoordinator.swift
//  Trial
//
//  Created by Radek on 27.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import UIKit
import RxSwift

protocol TransactionsCoordinatorProtocol: Coordinator {}

class TransactionsCoordinator: TransactionsCoordinatorProtocol {
    let navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() -> Single<Void> {
        let transactionsViewController = Container.shared.transactionsViewController()
        let transactionsViewModel = Container.shared.transactionsViewModel(transactionsViewController.viewModelInput)
        transactionsViewController.bind(viewModel: transactionsViewModel)
        
        navigationController.pushViewController(transactionsViewController, animated: true)
        
        return .never()
    }
}

extension Container {
    var transactionsCoordinator: ParameterFactory<UINavigationController, TransactionsCoordinatorProtocol> {
        self(TransactionsCoordinator.init)
    }
}
