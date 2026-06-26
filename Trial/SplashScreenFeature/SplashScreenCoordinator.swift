//
//  SplashScreenCoordinator.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import UIKit
import RxSwift

protocol SplashScreenCoordinatorProtocol: Coordinator {}

class SplashScreenCoordinator: SplashScreenCoordinatorProtocol {
    let viewController: UIViewController
    
    var childCoordinators: [Coordinator] = []
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func start() -> Single<Void> {
        let splashScreenViewController = Container.shared.splashScreenViewController()
        let splashScreenViewModel = Container.shared.splashScreenViewModel(splashScreenViewController.viewModelInput)
        splashScreenViewController.bind(viewModel: splashScreenViewModel)
        
        splashScreenViewController.isModalInPresentation = true
        viewController.present(splashScreenViewController, animated: true)
        
        return splashScreenViewModel.outputToCoordinator
            .dismiss
            .flatMap { [weak viewController] in
                viewController?.dismiss(animated: true)
                return .just(())
            }
    }
}

extension Container {
    var splashScreenCoordinator: ParameterFactory<UIViewController, SplashScreenCoordinatorProtocol> {
        self(SplashScreenCoordinator.init)
    }
}
