//
//  UIFont.swift
//  WedoTalk
//
//  Created by 觅蓝科技 on 2022/4/2.
//

import UIKit

extension UIFont {
    
    // 可以通过let names = UIFont.fontNames(forFamilyName: "PingFang SC") 来遍历所有PingFang 的字体名字 iOS9.0 以后支持
    /*
     PingFangSC-Medium
     PingFangSC-Semibold
     PingFangSC-Light
     PingFangSC-Ultralight
     PingFangSC-Regular
     PingFangSC-Thin
     */

    public static func pingFangRegular(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Regular", size: size * widthScale) else {
            return UIFont.systemFont(ofSize: size * widthScale)
        }
        return font
    }

    public static func pingFangMedium(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Medium", size: size * widthScale) else {
            return UIFont.systemFont(ofSize: size * widthScale)
        }
        return font
    }

    public static func pingFangSemibold(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Semibold", size: size * widthScale) else {
            return UIFont.systemFont(ofSize: size * widthScale)
        }
        return font
    }
    
    public static func pingFangLight(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Light", size: size * widthScale) else {
            return UIFont.systemFont(ofSize: size * widthScale)
        }
        return font
    }
    public static func pingFangThin(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Thin", size: size * widthScale) else {
            return UIFont.systemFont(ofSize: size * widthScale)
        }
        return font
    }
    public static func pingFangUltralight(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Ultralight", size: size * widthScale) else {
            return UIFont.systemFont(ofSize: size * widthScale)
        }
        return font
    }
    

}
