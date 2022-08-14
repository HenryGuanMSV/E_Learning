//
//  UIViewController.swift
//  E_Learning
//
//  Created by sin on 2021/10/19.
//

import UIKit

/** UIViewController扩展类 */
extension UIViewController {
    /** 设置带动作的导航栏 */
    func setBackNavigationBarWithAction(imageName: String = "nav_back_active", action : Selector) {
        setLeftNavigationItemWithNormal(imageName: imageName, highlightImageName: "", size: CGSize(width: 12, height: 20), action: action)
    }
    
    /** 设置左边的按钮带图片 */
    func setLeftNavigationItemWithNormal(imageName : String, highlightImageName : String, size : CGSize, action : Selector) {
        // 自定义按钮
        let leftBtn : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        if #available(iOS 11.0, *) {
            // 坐标
            leftBtn.frame = CGRect(x: 0, y: 10, width: size.width, height: size.height)
        } else {
            // 坐标
            leftBtn.frame = CGRect(x: 0, y: 5, width: size.width, height: size.height)
        }
        // 点击事件
        leftBtn.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        // 图片
        leftBtn.setImage(UIImage.init(named: imageName), for: UIControl.State.normal)
        // 高亮图片
        if !highlightImageName.isEmpty {
            leftBtn.setImage(UIImage.init(named: highlightImageName), for: UIControl.State.highlighted)
        }
        // 文字大小
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        // 文字颜色
        leftBtn.titleLabel?.textColor = .white
        
        // 新增按钮扩大点击范围
        let button : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: -10, y: 0, width: 60, height: 40)
        button.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
//        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.addSubview(leftBtn)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /** 设置左边的按钮带文字 */
    func setLeftNavigationItemText(imageName : String, text : String, action : Selector) -> UILabel {
        // 自定义按钮
        let leftBtn : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        let label = UILabel()
        if #available(iOS 11.0, *) {
            // 坐标
            if imageName.isBlank == true {
                label.frame = CGRect(x: 0, y: 10, width: 150, height: 20)
            } else {
                leftBtn.frame = CGRect(x: 0, y: 10, width: 12, height: 20)
                label.frame = CGRect(x: 16, y: 10, width: 150, height: 20)
            }
        } else {
            // 坐标
            if imageName.isBlank == true {
                label.frame = CGRect(x: 0, y: 5, width: 150, height: 20)
            } else {
                leftBtn.frame = CGRect(x: 0, y: 5, width: 12, height: 20)
                label.frame = CGRect(x: 16, y: 5, width: 150, height: 20)
            }
        }
        // 点击事件
        leftBtn.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        // 图片
        leftBtn.setImage(UIImage.init(named: imageName), for: UIControl.State.normal)
        // 文字大小
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        // 文字颜色
        leftBtn.titleLabel?.textColor = .white
        // 文字和图片的间距
        leftBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        label.text = text
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        
        // 新增按钮扩大点击范围
        let button : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: -10, y: 0, width: 60, height: 40)
        button.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        if imageName.isBlank == true {
            button.addSubview(label)
        } else {
            button.addSubview(leftBtn)
            button.addSubview(label)
        }
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        return label
    }
    
    /** 设置左边按钮 - 地图 */
    func setLeftMapItemWithAction(imageName : String, action : Selector) {
        // 自定义按钮
        let leftBtn : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
//        if #available(iOS 11.0, *) {
//            // 坐标
//            leftBtn.frame = CGRect(x: 0, y: 10, width: size.width, height: size.height)
//        } else {
            // 坐标
            leftBtn.frame = CGRect(x: 0, y: 5, width: 28, height: 28)
//        }
        // 点击事件
        leftBtn.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        // 图片
        leftBtn.setImage(UIImage.init(named: imageName), for: UIControl.State.normal)
        
        // 新增按钮扩大点击范围
        let button : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: -10, y: 0, width: 60, height: 40)
        button.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        button.addSubview(leftBtn)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /** 导航栏右侧图标 */
    func setRightNavigationImage(imageName : String, action : Selector) {
        // 创建右侧按钮
        let rightBtn : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        
        if !imageName.isEmpty {
            rightBtn.setImage(UIImage.init(named: imageName), for: UIControl.State.normal)
        }
        
        rightBtn.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
    }
    
    /** 设置右边的按钮 - 图标、最右边为第一个，内侧为第二个 */
    func setRightNavigationDoubleImage(firstImg : String, secondImg : String, firstAction : Selector, secondAction : Selector) {
        setRightNavigationDoubleImage(firstImg: firstImg, firstSelectImg: "", secondImg: secondImg, secondSelectImg: "", firstAction: firstAction, secondAction: secondAction)
    }
    
    func setRightNavigationDoubleImage(firstImg : String, firstSelectImg : String, secondImg : String, secondSelectImg : String, firstAction : Selector, secondAction : Selector) {
        let rightFirstButton : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightFirstButton.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        rightFirstButton.setImage(UIImage.init(named: firstImg), for: UIControl.State.normal)
        rightFirstButton.setImage(UIImage.init(named: firstSelectImg), for: UIControl.State.selected)
        rightFirstButton.addTarget(self, action: firstAction, for: UIControl.Event.touchUpInside)
        
        let rightFirstButtonItem = UIBarButtonItem(customView: rightFirstButton)
        
        let rightSecondButton : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightSecondButton.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        rightSecondButton.setImage(UIImage.init(named: secondImg), for: UIControl.State.normal)
        rightSecondButton.setImage(UIImage.init(named: secondSelectImg), for: UIControl.State.selected)
        rightSecondButton.addTarget(self, action: secondAction, for: UIControl.Event.touchUpInside)
        
        let rightSecondButtonItem = UIBarButtonItem(customView: rightSecondButton)
        
        // 设置2个按钮之间的间距
        let itemSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        // 负数为右移，正数为左移
        itemSpace.width = 30
        
        // 导航栏右侧文字
        self.navigationItem.setRightBarButtonItems([rightFirstButtonItem, itemSpace, rightSecondButtonItem], animated: true)
    }
    
    func setRightNavigationTitle(title : String, action : Selector, _ size : CGSize? = CGSize(width: 44, height: 44), _ backgroundColor : UIColor? = .clear, _ cornerRadius : CGFloat? = 0) {
        self.navigationItem.setRightBarButtonItems([], animated: false)
        
        // 创建右侧按钮
        let rightBtn : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightBtn.frame = CGRect(x: 0, y: 0, width: size?.width ?? 44, height: size?.height ?? 44)
        rightBtn.setTitle(title, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        rightBtn.setTitleColor(.white, for: .normal)
        rightBtn.backgroundColor = backgroundColor
        rightBtn.layer.cornerRadius = cornerRadius ?? 0
        rightBtn.layer.masksToBounds = true
        
        rightBtn.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
    }
    
    func setRightNavigationMeTitle(title : String, action : Selector ,frame : CGRect? = CGRect(x: 0, y: 0, width: 44, height: 44)) -> UIButton {
        self.navigationItem.setRightBarButtonItems([], animated: false)
        
        // 创建右侧按钮
        let rightBtn : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightBtn.frame = frame!
        rightBtn.setTitle(title, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        rightBtn.setTitleColor(UIColor.colorWithString("#C9C9CA"), for: .normal)
        
        rightBtn.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        return rightBtn
    }
    
    func setRightNavigationDoubleTitle(firstTitle : String, secondTitle : String, firstAction : Selector, secondAction : Selector) {
        self.navigationItem.rightBarButtonItem = nil
        
        let rightFirstButton : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightFirstButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        rightFirstButton.setTitle(firstTitle, for: .normal)
        rightFirstButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        rightFirstButton.setTitleColor(UIColor.colorWithString("#C9C9CA"), for: .normal)
        rightFirstButton.addTarget(self, action: firstAction, for: UIControl.Event.touchUpInside)
        
        let rightFirstButtonItem = UIBarButtonItem(customView: rightFirstButton)
        
        let rightSecondButton : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightSecondButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        rightSecondButton.setTitle(secondTitle, for: .normal)
        rightSecondButton.setTitleColor(UIColor.colorWithString("#C9C9CA"), for: .normal)
        rightSecondButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        rightSecondButton.addTarget(self, action: secondAction, for: UIControl.Event.touchUpInside)
        
        let rightSecondButtonItem = UIBarButtonItem(customView: rightSecondButton)
        
        // 设置2个按钮之间的间距
        let itemSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        // 负数为右移，正数为左移
        itemSpace.width = 0
        
        // 导航栏右侧文字
        self.navigationItem.setRightBarButtonItems([rightFirstButtonItem, itemSpace, rightSecondButtonItem], animated: true)
    }
}
