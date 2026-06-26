//
//  GetAppLaunchCountUseCase.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit

protocol GetAppLaunchCountUseCaseProtocol {
    func callAsFunction() -> Int
}

class GetAppLaunchCountUseCase: GetAppLaunchCountUseCaseProtocol {
    @Injected(\.keyValueStorage) var keyValueStorage
    
    func callAsFunction() -> Int {
        keyValueStorage.value(forKey: Constant.appLaunchCountKey) ?? .zero
    }
}

private enum Constant {
    static let appLaunchCountKey: String = "app_launch_count"
}

extension Container {
    var getAppLaunchCountUseCase: Factory<GetAppLaunchCountUseCaseProtocol> {
        self(GetAppLaunchCountUseCase.init)
    }
}
