//
//  ELCheckNetwork.swift
//  E_Learning 检查网络环境
//
//  Created by sin on 2021/10/12.
//

import Reachability
import UIKit

typealias wifiReachability = () -> Void
typealias cellularReachability = () -> Void
typealias notNetworkReachability = () -> Void

/** 网络状态 */
enum ELNetworkStatus : Int {
    case none = 1
    case wifi = 2
    case cellular = 3
}

/** 监控网络 */
class ELCheckNetwork : NSObject {
    static let shared = ELCheckNetwork()
    
    let reachability = try! Reachability()
    var wifiBlock : wifiReachability?
    var cellularBlock : cellularReachability?
    var notNetworkBlock : notNetworkReachability?
    
    private override init(){}

    /** 监控网络状态 */
    func checkNetworkState() {
        weak var weakSelf = self
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
    //            print("Reachable via WiFi")
                if weakSelf?.wifiBlock != nil {
                    weakSelf?.wifiBlock!()
                }
            } else if (reachability.connection == .cellular) {
    //            print("Reachable via Cellular")
                if weakSelf?.cellularBlock != nil {
                    weakSelf?.cellularBlock!()
                }
    //        } else if (reachability.connection == .unavailable) {
    //            print("Network not reachable")
            } else {
    //            print("not Network")
                if weakSelf?.notNetworkBlock != nil {
                    weakSelf?.notNetworkBlock!()
                }
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    /** 观察者模式 */
    func networkNotification () {
        // declare this inside of viewWillAppear
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
            case .wifi:
//                print("Reachable via WiFi")
                if self.wifiBlock != nil {
                    self.wifiBlock!()
                }
                break
            case .cellular:
//                print("Reachable via Cellular")
                if self.cellularBlock != nil {
                    self.cellularBlock!()
                }
                break
            case .unavailable:
//                print("Network not reachable")
                if self.notNetworkBlock != nil {
                    self.notNetworkBlock!()
                }
                break
            case .none:
                if self.notNetworkBlock != nil {
                    self.notNetworkBlock!()
                }
                break
        }
    }

    /** 获取一次性网络状态 */
    func checkNetworkOnce() -> ELNetworkStatus {
        // wifi、蜂窝移动
        if self.reachability.connection == .wifi {
            return .wifi
        } else if self.reachability.connection == .cellular {
            return .cellular
        }
        
        return .none
    }
    
    /** 获取一次性网络状态 */
    func checkNetworkOnceBool() -> Bool {
        // wifi、蜂窝移动
        if self.reachability.connection == .wifi || self.reachability.connection == .cellular {
            return true
        }
        
        return false
    }
    
    /** 关闭监控 */
    func stopCheckNetwork() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self)
    }

//    /** Wi-Fi */
//    func wifiBlocks(_ block: @escaping wifiReachability) {
//        wifiBlock = block
//    }
//
//    /** 蜂窝移动 */
//    func cellularBlocks(_ block: @escaping cellularReachability) {
//        cellularBlock = block
//    }
//
//    /** 无网络 */
//    func notNetworkBlocks(_ block: @escaping notNetworkReachability) {
//        notNetworkBlock = block
//    }
}
