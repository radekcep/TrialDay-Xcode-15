//
//  UIFont+.swift
//  Trial
//
//  Created by Radek on 29.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import UIKit

extension UIFont {
    static var heavyTitle: UIFont {
        .systemFont(ofSize: 32, weight: .heavy)
    }
    
    static var title: UIFont {
        .systemFont(ofSize: 20, weight: .bold)
    }
    
    static var subtitle: UIFont {
        .systemFont(ofSize: 18)
    }
    
    static var boldBody: UIFont {
        .systemFont(ofSize: 16, weight: .bold)
    }
    
    static var lightBody: UIFont {
        .systemFont(ofSize: 16, weight: .light)
    }
}
