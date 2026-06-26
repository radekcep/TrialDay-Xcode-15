//
//  Container+mainScheduler.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import RxSwift

extension Container {
    var mainScheduler: Factory<SchedulerType> {
        self { MainScheduler.instance }
    }
}
