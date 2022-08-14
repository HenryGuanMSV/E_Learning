//
//  WJCoreManage.swift
//  E_Learning
//
//  Created by sin on 2022/3/30.
//

import UIKit
import SHFullscreenPopGestureSwift
import IQKeyboardManagerSwift

/** 核心管理类 */
class ELCoreManager: NSObject {
    static let shared = ELCoreManager()
    
    private override init(){}
    
    /** 启动方法 */
    func start() {
        // 启用全屏侧滑
        SHFullscreenPopGesture.configure()
        // 键盘监控
        IQKeyboardManager.shared.enable = true
        setupIQKeyboard()
        toMainVC()
    }
    
    func setupIQKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    /** 跳转root控制器->首页*/
    func toMainVC() {
        let tabbar = ELRootTabbarController()
        ELWindow?.rootViewController = tabbar.noWrappingNavigationController
    }
}



