//
//  WJDarkModeUtil.swift
//  E_Learning
//
//  Created by Sin on 2022/4/2.
//

import UIKit

/** 正常 or 暗黑模式切换 */
class ELDarkModeUtil {
    /** 跟随系统的key */
    private static let WJDarkToSystem = "ELDarkToSystem"
    /** 是否正常模式 */
    private static let WJLightDark = "ELLightDark"
    
    /** 是否浅色 */
    static var isLight : Bool {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return false
            }
        }
        return true
    }
    
    /** 是否暗黑色 */
    static var isDark : Bool {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return true
            }
        }
        return false
    }
    
    /** 是否跟随系统 */
    static func isFloorSystem(_ isSystem : Bool) {
        // 跟随系统
        if #available(iOS 13.0, *) {
            if isSystem == true {
                UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .unspecified
            } else {
                UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    /** 浅色模式 */
    static func lightMode() {
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .light
        }
    }
    
    /** 深色模式 */
    static func darkMode() {
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .dark
        }
    }
}

