//
//  GetTransactionsUseCase.swift
//  Trial
//
//  Created by Radek on 27.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import RxSwift

protocol GetTransactionsUseCaseProtocol {
    func callAsFunction() -> Single<[Transaction]>
}

class GetTransactionsUseCase: GetTransactionsUseCaseProtocol {
    @Injected(\.transactionsAPI) var transactionsAPI
    
    func callAsFunction() -> Single<[Transaction]> {
        .create { [transactionsAPI] observer in
            transactionsAPI.loadTransactions { result in
                observer(result.mapError { $0 as Error })
            }
            
            return Disposables.create()
        }
    }
}

extension Container {
    var getTransactionsUseCase: Factory<GetTransactionsUseCaseProtocol> {
        self(GetTransactionsUseCase.init)
    }
}
