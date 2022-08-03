//
//  WJSystemTools.swift
//  E_Learning
//
//  Created by Sin on 2021/10/20.
//

import UIKit
import AudioToolbox

class ELSystemTools {
    static let shared = ELSystemTools()
    /** 当前类 */
    var topViewController : UIViewController?
    
    private init(){}
    
    /** 跳转Safari浏览器 */
    func pushSafari(urlString : String) {
        if let url = URL(string: urlString) {
            // 根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func iPhoneX() -> Bool {
        if #available(iOS 11, *) {
              guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                  return false
              }
              
              if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
//                  print(unwrapedWindow.safeAreaInsets)
                  return true
              }
        }
        return false
    }

    /** 安全区域 */
    static func safeArea() -> UIEdgeInsets {
        if #available(iOS 11, *) {
              if let w = UIApplication.shared.delegate?.window,
                 let inserts = w?.safeAreaInsets {
                  return inserts
              }
        }
        
        return .zero
    }
    
    /** 导航栏高度 */
    static func viewTop() -> CGFloat {
        NAVIGATIONBAR_HEIGHT + safeArea().top
    }
    
    /** 设备id */
    static var deviceId: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    /** 设备名称 */
    static var deviceName: String {
        return UIDevice.current.name
    }
    
    /** 设备系统名称 */
    static var systemName: String {
        return UIDevice.current.systemName
    }
    
    /** 设备系统版本 */
    static var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    /** APP名称 */
    static var appName: String {
        getSystemInfo("CFBundleDisplayName")
    }
    
    /** APP版本号 */
    static var version: String {
        getSystemInfo("CFBundleShortVersionString")
    }
    
    /** APP build版本 */
    static var appBuild: String {
        getSystemInfo("CFBundleVersion")
    }
    
    /** 获取系统信息 */
    private static func getSystemInfo(_ value : String) -> String {
        let infoDictionary = Bundle.main.infoDictionary
        let result: String? = infoDictionary![value] as? String
        return result ?? ""
    }
    
    /** 获取系统声音 */
    static func systemSound() {
        let systemSoundID : SystemSoundID = 1004
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    /** 静音模式下震动，非静音提示音 */
    static func systemAlert() {
        let systemSoundID : SystemSoundID = 1004
        AudioServicesPlayAlertSound(systemSoundID)
    }
    
    /** 震动 */
    static func systemVibration() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    /** 设备型号 */
    static var deviceModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
            case "iPod1,1":     return "iPod Touch 1"
            case "iPod2,1":     return "iPod Touch 2"
            case "iPod3,1":     return "iPod Touch 3"
            case "iPod4,1":     return "iPod Touch 4"
            case "iPod5,1":     return "iPod Touch (5 Gen)"
            case "iPod7,1":     return "iPod Touch 6"

            case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
            case "iPhone4,1":   return "iPhone 4s"
            case "iPhone5,1":   return "iPhone 5"
            case  "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
            case "iPhone5,3":   return "iPhone 5c (GSM)"
            case "iPhone5,4":   return "iPhone 5c (GSM+CDMA)"
            case "iPhone6,1":   return "iPhone 5s (GSM)"
            case "iPhone6,2":   return "iPhone 5s (GSM+CDMA)"
            case "iPhone7,2":   return "iPhone 6"
            case "iPhone7,1":   return "iPhone 6 Plus"
            case "iPhone8,1":   return "iPhone 6s"
            case "iPhone8,2":   return "iPhone 6s Plus"
            case "iPhone8,4":   return "iPhone SE"
            case "iPhone9,1":   return "iPhone 7"
            case "iPhone9,2":   return "iPhone 7 Plus"
            case "iPhone9,3":   return "iPhone 7"
            case "iPhone9,4":   return "iPhone 7 Plus"
            case "iPhone10,1","iPhone10,4":   return "iPhone 8"
            case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
            case "iPhone10,3","iPhone10,6":   return "iPhone X"
            case "iPhone11,2":  return "iPhone XS"
            case "iPhone11,6":  return "iPhone XS Max"
            case "iPhone11,8":  return "iPhone XR"
            case "iPhone12,1":  return "iPhone 11"
            case "iPhone12,3":  return "iPhone 11 Pro"
            case "iPhone12,5":  return "iPhone 11 Pro Max"
            case "iPhone13,1":  return "iPhone 12 mini"
            case "iPhone13,2":  return "iPhone 12"
            case "iPhone13,3":  return "iPhone 12 Pro"
            case "iPhone13,4":  return "iPhone 12 Pro Max"

            case "iPad1,1":     return "iPad"
            case "iPad1,2":     return "iPad 3G"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
            case "iPad2,5", "iPad2,6", "iPad2,7":   return "iPad Mini"
            case "iPad3,1", "iPad3,2", "iPad3,3":   return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
            case "iPad4,4", "iPad4,5", "iPad4,6":   return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":   return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":      return "iPad Mini 4"
            case "iPad5,3", "iPad5,4":      return "iPad Air 2"
            case "iPad6,3", "iPad6,4":      return "iPad Pro 9.7"
            case "iPad6,7", "iPad6,8":      return "iPad Pro 12.9"
            case "AppleTV2,1":              return "Apple TV 2"
            case "AppleTV3,1","AppleTV3,2": return "Apple TV 3"
            case "AppleTV5,3":              return "Apple TV 4"
            case "i386", "x86_64":          return "Simulator"
            default:                        return identifier
        }
    }
}
