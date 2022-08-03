//
//  UIAlertController.swift
//  WedoTalk
//
//  Created by luigi on 2022/6/17.
//

import UIKit

extension UIAlertController {
    //在指定视图控制器上弹出普通消息提示框
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    //在根视图控制器上弹出普通消息提示框
    static func showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }
     
    //在指定视图控制器上弹出确认框
    static func showConfirm(message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirm))
        viewController.present(alert, animated: true)
    }
     
    //在根视图控制器上弹出确认框
    static func showConfirm(message: String, confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showConfirm(message: message, in: vc, confirm: confirm)
        }
    }
    //在指定视图控制器上弹出自定义提示框
    static func showCustomAlert(message: String,leftTitle :String ,rightTitle :String, in viewController: UIViewController,
                                  leftAction: ((UIAlertAction)->Void)? ,rightAction : ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: leftTitle, style: .default, handler: leftAction))
        alert.addAction(UIAlertAction(title: rightTitle, style: .default, handler: rightAction))
        viewController.present(alert, animated: true)
    }
     
    //在根视图控制器上弹出自定义提示框
    static func showCustomAlert(message: String,leftTitle :String ,rightTitle :String,
                                  leftAction: ((UIAlertAction)->Void)? ,rightAction : ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showCustomAlert(message: message, leftTitle: leftTitle, rightTitle: rightTitle, in: vc, leftAction: leftAction, rightAction: rightAction)
        }
    }
    
    //底部自定义actionSheet
    static func showCustomActionSheet(message: String,bottomTitle :String ,topTitle :String, in viewController: UIViewController,
                                bottomAction: ((UIAlertAction)->Void)? ,topAction : ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: bottomTitle, style: .default, handler: bottomAction))
        alert.addAction(UIAlertAction(title: topTitle, style: .default, handler: topAction))
        viewController.present(alert, animated: true)
    }

}
