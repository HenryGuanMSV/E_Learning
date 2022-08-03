//
//  UIButton.swift
//  WedoTalk
//
//  Created by bruce on 2021/11/23.
//

import UIKit

//MARK: -定义button相对label的位置
enum YWButtonEdgeInsetsStyle {
    case Top
    case Left
    case Right
    case Bottom
}

extension UIButton {
    /** 按钮图片文字上下排版 */
    func setButtonPictureAbove() {
        let imageSize : CGSize = self.imageView!.frame.size
        let titleSize : CGSize = self.titleLabel!.frame.size
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left:-imageSize.width, bottom: -imageSize.height - 5, right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - 5, left: 0, bottom: 0, right: -titleSize.width)
    }
    
    /** 按钮图片右排版 */
    func setButtonPictureRight() {
        let imageSize : CGSize = self.imageView!.frame.size
        let titleSize : CGSize = self.titleLabel!.frame.size
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: imageSize.width)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width * 2, bottom: 0, right: 0)
    }
    
    /** 创建按钮 */
    public static func initBtn(title: String, titleColor: UIColor, font: UIFont ) -> UIButton {
        let button = UIButton.init(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        return button
    }

    func layoutButton(style: YWButtonEdgeInsetsStyle, imageTitleSpace: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
     
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
            case .Top:
                //上 左 下 右
                imageEdgeInsets = UIEdgeInsets(top: -labelHeight-imageTitleSpace/2, left: 0, bottom: 0, right: -labelWidth)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-imageTitleSpace/2, right: 0)
                break;
                
            case .Left:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace/2, bottom: 0, right: imageTitleSpace)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace/2, bottom: 0, right: -imageTitleSpace/2)
                break;
                
            case .Bottom:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-imageTitleSpace/2, right: -labelWidth)
                labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-imageTitleSpace/2, left: -imageWidth!, bottom: 0, right: 0)
                break;
                
            case .Right:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+imageTitleSpace/2, bottom: 0, right: -labelWidth-imageTitleSpace/2)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-imageTitleSpace/2, bottom: 0, right: imageWidth!+imageTitleSpace/2)
                break;
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}
