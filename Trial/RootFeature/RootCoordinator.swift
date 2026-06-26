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

protocol RootCoordinatorProtocol {
    func start() -> Observable<Never>
}

class RootCoordinator: RootCoordinatorProtocol {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() -> Observable<Never> {
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        return .never()
    }
}

extension Container {
    var rootCoordinator: ParameterFactory<UIWindow, RootCoordinatorProtocol> {
        self(RootCoordinator.init)
    }
}
