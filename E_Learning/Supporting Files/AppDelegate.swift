//
//  AppDelegate.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/2.
//

import UIKit
import SwifterSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = ViewController()
        window?.backgroundColor = .white
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }

}

