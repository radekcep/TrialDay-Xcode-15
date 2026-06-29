//
//  UIButton+Configuration.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import UIKit

extension UIButton.Configuration {
    static var primary: Self {
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = .init(top: Spacing.s, leading: Spacing.s, bottom: Spacing.s, trailing: Spacing.s)
        configuration.baseBackgroundColor = UIColor(resource: .primary)
        return configuration
    }
}
