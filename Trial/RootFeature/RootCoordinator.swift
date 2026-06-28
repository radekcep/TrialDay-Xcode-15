//
//  RootCoordinator.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import UIKit
import RxSwift

protocol RootCoordinatorProtocol: Coordinator {}

class RootCoordinator: RootCoordinatorProtocol {
    @Injected(\.getAppLaunchCountUseCase) var getAppLaunchCountUseCase
    @Injected(\.incrementAppLaunchCountUseCase) var incrementAppLaunchCountUseCase
    
    let window: UIWindow
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() -> Single<Void> {
        let rootViewController = UINavigationController()
        rootViewController.view.backgroundColor = .systemBackground
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        incrementAppLaunchCountUseCase()
        
        return if getAppLaunchCountUseCase() == 1 {
            presentSplash(over: rootViewController)
                .asObservable()
                .withUnretained(self)
                .flatMapLatest { $0.0.presentTransactionsList(in: rootViewController) }
                .asSingle()
        } else {
            presentTransactionsList(in: rootViewController)
        }
    }
}

private extension RootCoordinator {
    func presentSplash(over viewController: UIViewController) -> Single<Void> {
        let splashScreenCoordinator = Container.shared.splashScreenCoordinator(viewController)
        return start(splashScreenCoordinator)
    }
    
    func presentTransactionsList(in navigationController: UINavigationController) -> Single<Void> {
        let transactionsCoordinator = Container.shared.transactionsCoordinator(navigationController)
        return start(transactionsCoordinator)
    }
}

extension Container {
    var rootCoordinator: ParameterFactory<UIWindow, RootCoordinatorProtocol> {
        self(RootCoordinator.init)
    }
}
