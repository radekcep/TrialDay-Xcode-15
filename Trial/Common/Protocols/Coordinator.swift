//
//  Coordinator.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import RxSwift

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start() -> Single<Void>
}

extension Coordinator {
    func start(_ childCoordinator: Coordinator) -> Single<Void> {
        childCoordinators.append(childCoordinator)
        
        return childCoordinator.start()
            .do(onDispose: { [weak self, weak childCoordinator] in
                self?.childCoordinators.removeAll { $0 === childCoordinator }
            })
        }
}
