//
//  Navigator+Home.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/15.
//

import Foundation
import RTRootNavigationController
import UIKit


extension Navigator {
    static func nav2TestVC(_ nav:RTRootNavigationController? = nil) {
        let controller       = UIViewController()
        controller.title     = "聊天设置"
        controller.view.backgroundColor = .red
        let rootNavc = (nav ?? rootNavigationController)
        rootNavc?.pushViewController(controller, animated: true)
    }
}
