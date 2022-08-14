//
//  AppDelegate.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/2.
//

import UIKit
import SwifterSwift
import XCGLogger
import RxSwift
import IQKeyboardManagerSwift

let log = XCGLogger.default
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var visualEffectView : UIVisualEffectView?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // 指定根视图
        self.window?.makeKeyAndVisible()
        // 启动核心管理类
        ELCoreManager.shared.start()
        
        return true
    }

    /** 回到后台 */
    func applicationDidEnterBackground(_ application: UIApplication) {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.5) {
            // 设置模糊程度
            weakSelf?.visualEffectView?.alpha = 1
        }
    }

    /** 当App从后台即将回到前台时触发此事件 */
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    /** 处理事件的后台URL会话 */
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
    }

    /** 当App退出时触发此方法，一般用于保存某些特定的数据 */
    func applicationWillTerminate(_ application: UIApplication) {
        
    }

    /** 失去焦点*/
    func applicationWillResignActive(_ application: UIApplication) {
        weak var weakSelf = self
       // 创建你需要的毛玻璃特效 - 将毛玻璃特效添加到view中
       self.visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
       // 设置模糊程度
       self.visualEffectView?.alpha = 0
       // 设置比例
       self.visualEffectView?.frame = self.window?.bounds ?? UIScreen.main.bounds
       // 添加到当前view
       self.window?.addSubview(self.visualEffectView ?? UIVisualEffectView(effect: UIBlurEffect(style: .light)))
       // 当后台时毛玻璃状态
    
       UIView.animate(withDuration: 0.5) {
           // 设置模糊程度
           weakSelf?.visualEffectView?.alpha = 1
       }
    }

    /** 进入前台*/
    func applicationDidBecomeActive(_ application: UIApplication) {
        weak var weakSelf = self
               // 当恢复时毛玻璃状态
           UIView.animate(withDuration: 0.5, animations: {
               // 正常情况，设置毛玻璃状态为0
               weakSelf?.visualEffectView?.alpha = 0
           }, completion: { finished in
               // 错误情况删除毛玻璃对象
               weakSelf?.visualEffectView?.removeFromSuperview()
           })
    }

    /** 强制设备只能竖屏 */
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

