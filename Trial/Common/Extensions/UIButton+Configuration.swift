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
        configuration.contentInsets = .init(top: Spacing.xs, leading: Spacing.s, bottom: Spacing.xs, trailing: Spacing.s)
        return configuration
    }
    
    static var secondary: Self {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = .init(top: Spacing.xs, leading: Spacing.xs, bottom: Spacing.xs, trailing: Spacing.xs)
        return configuration
    }
}
