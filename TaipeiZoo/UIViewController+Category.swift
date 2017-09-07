//
//  UIViewController+Category.swift
//  TaipeiZoo
//
//  Created by alex on 06/09/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit

extension UIViewController {
    var contents: UIViewController {
        if let navCon = self as? UINavigationController {
            return navCon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
