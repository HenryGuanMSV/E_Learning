//
//  ELBasicView.swift
//  E_Learning
//
//  Created by sin on 2022/7/25.
//

import UIKit

let defaultCorner = 8.0
let defaultShadow = 120.0

class ELBasicView: UIView {

    /** 自定义view */
//    + (instancetype)customView {
//        return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
//    }
    
    static func loadFromNib(_ nibname:String? = nil,index:Int = 0) -> Self {
        /// self(小写)当前对象
        let loadName = nibname == nil ? "\(Self.self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)![index] as! Self
    }
    
   // 添加圆角
    func addDefaultCorner() {
        self.layer.cornerRadius = scaleNum(defaultCorner)
    }
    
    // 添加阴影
    func addDefaultShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = scaleNum(defaultShadow)
        self.layer.shadowColor = UIColor.shadowColor.cgColor
    }
}
