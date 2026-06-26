//
//  SceneDelegate.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var rootCoordinator: RootCoordinatorProtocol?
    var disposeBag = DisposeBag()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let rootCoordinator = Container.shared.rootCoordinator(window)
        self.rootCoordinator = rootCoordinator
        
        rootCoordinator
            .start()
            .subscribe()
            .disposed(by: disposeBag)
    }
}
