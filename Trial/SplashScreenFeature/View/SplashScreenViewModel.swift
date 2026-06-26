//
//  SplashScreenViewModel.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import RxSwift

class SplashScreenViewModel {
    struct InputFromView {
        let userClickedOnCTA: Observable<Void>
    }
    
    struct OutputToCoordinator {
        let dismiss: Single<Void>
    }
    
    let inputFromView: InputFromView
        
    lazy var outputToCoordinator = OutputToCoordinator(
        dismiss: inputFromView.userClickedOnCTA.first().map { _ in }
    )
    
    init(inputFromView: InputFromView) {
        self.inputFromView = inputFromView
    }
}

extension Container {
    var splashScreenViewModel: ParameterFactory<SplashScreenViewModel.InputFromView, SplashScreenViewModel> {
        self(SplashScreenViewModel.init)
    }
}
