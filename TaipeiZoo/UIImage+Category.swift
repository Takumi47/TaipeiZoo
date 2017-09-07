//
//  UIImage+Category.swift
//  iApp
//
//  Created by smallHappy on 2016/8/8.
//  Copyright © 2016年 smallHappy. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageWithColor(_ color:UIColor) -> UIImage {
        let rect:CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale)
        color.setFill()
        UIRectFill(rect)
        self.draw(in: rect, blendMode: .destinationIn, alpha: 1.0)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func imageWithGrayScale() -> UIImage {
        let rect:CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let context = CGContext(data: nil, width: Int(rect.size.width), height: Int(rect.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: .allZeros)
        context?.draw(self.cgImage!, in: rect);
        let imageRef = context?.makeImage();
        let newImage = UIImage(cgImage: imageRef!)
        
        return newImage
    }
    
    func imageWithSize(_ size:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func imageWithText(text:String, atPoint:CGPoint) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let textFontAttributes = [
            NSFontAttributeName: UIFont(name: "Helvetica Bold", size: 80)!,
            NSForegroundColorAttributeName: UIColor.darkGray
        ]
        let rect = CGRect(x: atPoint.x, y: atPoint.y, width: self.size.width, height: self.size.height)
        text.draw(in: rect, withAttributes: textFontAttributes)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
