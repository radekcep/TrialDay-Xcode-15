//
//  TransactionDetailViewModel.swift
//  Trial
//
//  Created by Radek on 28.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import RxSwift

class TransactionDetailViewModel {
    struct InputFromView {
        let viewIsMovingFromParent: Observable<Void>
    }
    
    struct InputFromCoordinator {
        let transaction: Transaction
    }
    
    struct OutputToView {
        let title: String
        let subtitle: String?
    }
    
    struct OutputToCoordinator {
        let viewIsMovingFromParent: Observable<Void>
    }
    
    let inputFromView: InputFromView
    let inputFromCoordinator: InputFromCoordinator
     
    private(set) lazy var outputToView = OutputToView(
        title: inputFromCoordinator.transaction.title,
        subtitle: inputFromCoordinator.transaction.subtitle
    )
    
    private(set) lazy var outputToCoordinator = OutputToCoordinator(
        viewIsMovingFromParent: inputFromView.viewIsMovingFromParent
    )
    
    init(inputFromView: InputFromView, inputFromCoordinator: InputFromCoordinator) {
        self.inputFromView = inputFromView
        self.inputFromCoordinator = inputFromCoordinator
    }
}

extension Container {
    var transactionDetailViewModel: ParameterFactory<
        (TransactionDetailViewModel.InputFromView, TransactionDetailViewModel.InputFromCoordinator),
        TransactionDetailViewModel
    > {
        self(TransactionDetailViewModel.init)
    }
}
