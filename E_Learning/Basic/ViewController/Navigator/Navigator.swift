//
//  Navigator.swift
//  E_Learning
//
//  Created by sin on 2022/4/20.
//

import Foundation
import UIKit
import RTRootNavigationController

extension UINavigationController {
    override open var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? false
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (topViewController?.supportedInterfaceOrientations)!
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (topViewController?.preferredInterfaceOrientationForPresentation)!
    }

    override open var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}

class NavigationViewController: RTRootNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    override var childForStatusBarStyle: UIViewController? {
        return rt_topViewController
    }
    override var childForStatusBarHidden: UIViewController? {
        return rt_topViewController
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return rt_topViewController.supportedInterfaceOrientations
    }
}

var rootNavigationController: NavigationViewController? {
    var appWindow: UIWindow?
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window {
        appWindow = window
    } else if let window = UIApplication.shared.keyWindow {
        appWindow = window
    }
    guard let rootViewController = appWindow?.rootViewController else { return nil }
    guard let rtnav = rootViewController as? NavigationViewController else { return nil }
    for item in rtnav.viewControllers {
        if let container = item as? RTContainerController,
           let tabbar = container.contentViewController as? UITabBarController,
           let selected = tabbar.selectedViewController as? NavigationViewController
        {
            return selected
        }
    }
    return rtnav
}

final class Navigator {
    static let shared = Navigator()
    private init() {}
}
