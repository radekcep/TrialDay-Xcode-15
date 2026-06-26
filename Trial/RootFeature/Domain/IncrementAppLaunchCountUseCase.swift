//
//  IncrementAppLaunchCountUseCase.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit

protocol IncrementAppLaunchCountUseCaseProtocol {
    func callAsFunction()
}

class IncrementAppLaunchCountUseCase: IncrementAppLaunchCountUseCaseProtocol {
    @Injected(\.keyValueStorage) var keyValueStorage
    
    func callAsFunction() {
        let appLaunchCount = keyValueStorage.value(forKey: Constant.appLaunchCountKey) ?? .zero
        keyValueStorage.set(value: appLaunchCount + 1, forKey: Constant.appLaunchCountKey)
    }
}

private enum Constant {
    static let appLaunchCountKey: String = "app_launch_count"
}

extension Container {
    var incrementAppLaunchCountUseCase: Factory<IncrementAppLaunchCountUseCaseProtocol> {
        self(IncrementAppLaunchCountUseCase.init)
    }
}
