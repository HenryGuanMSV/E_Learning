//
//  UIApplication.swift
//  E_Learning
//
//  Created by Aiken on 2022/8/26.
//

import Foundation

extension UIApplication {
    
    static var isRTL: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == UIUserInterfaceLayoutDirection.rightToLeft
    }
}
