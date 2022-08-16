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
        let controller       = ELCourseDetailViewController()
        controller.title     = "课程详情"
        let rootNavc = (nav ?? rootNavigationController)
        rootNavc?.pushViewController(controller, animated: true)
    }
}
