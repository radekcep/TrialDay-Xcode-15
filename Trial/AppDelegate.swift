//
//  Copyright © 2022 Erste Group Bank AG. All rights reserved.
//

import FactoryKit
import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var disposeBag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        Container.shared.rootCoordinator(window)
            .start()
            .subscribe()
            .disposed(by: disposeBag)
        
        return true
    }
}
