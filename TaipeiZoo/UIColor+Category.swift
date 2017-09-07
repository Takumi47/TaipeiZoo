//
//  UIColor+Category.swift
//  DemoUIPickerView
//
//  Created by alex on 26/08/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex rgb: Int32) {
        let r = (rgb & 0xff0000) >> 16
        let g = (rgb & 0x00ff00) >> 8
        let b = rgb & 0x0000ff
        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: 1.0)
    }
}
