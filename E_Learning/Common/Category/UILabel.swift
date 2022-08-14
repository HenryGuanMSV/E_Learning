//
//  UILabel.swift
//  E_Learning
//
//  Created by sin on 2021/12/14.
//

import UIKit

/** 字体图标样式 */
enum WJFontsIcon : String {
    /** 勾 */
    case tick = "\u{e900}"
    /** 喇叭 */
    case horn = "\u{e901}"
    /** 大于 */
    case greater = "\u{e902}"
    /** 铃声 */
    case bell = "\u{e903}"
    /** 加 */
    case add = "\u{e904}"
    /** 二维码 */
    case qrCode = "\u{e905}"
}

extension UILabel {
    /** 获取labbel高度 */
    func currentHeight(text : String, font : UIFont, numberOfLines : Int, width : CGFloat) -> CGFloat {
       let label : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
       label.numberOfLines = numberOfLines
       label.lineBreakMode = NSLineBreakMode.byWordWrapping
       label.font = font
       label.text = text
       label.sizeToFit()

       return label.frame.height
    }
    
    /** 获取labbel宽度 */
    func currentWidth(text : String, font : UIFont, numberOfLines : Int, width : CGFloat) -> CGFloat {
       let label : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
       label.numberOfLines = numberOfLines
       label.lineBreakMode = NSLineBreakMode.byWordWrapping
       label.font = font
       label.text = text
       label.sizeToFit()

       return label.frame.width
    }
    
    public static func initLabel(text: String,textColor: UIColor, font: UIFont ) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = font
        label.text = text
        label.textAlignment = .left
        return label
    }
}

extension UILabel {
//    MARK: 带¥字符的金额Label变化样式(加入纯数字判断)
//    origiString   金额原始字符
//    RMBSize       人民币字符size
//    amountSize    金额size
//    color         颜色

     func formatNotPureAmountStringWithOriginalString(origiString : String, RMBSize : CGFloat, amountSize : CGFloat, textColor : UIColor) -> NSAttributedString {
        let formattedStr = NSMutableAttributedString(string: origiString)
        // 设置字符串颜色
        formattedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSMakeRange(0, formattedStr.length))
        // 改变金额字体大小
        formattedStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: amountSize), range: NSMakeRange(0, formattedStr.length))
//        let foundObj = NSRangeFromString("￥")
        let foundObj = formattedStr.mutableString.range(of: "￥")
        let yuanString = formattedStr.mutableString.range(of: "元")
        if foundObj.length > 0 {
            //设置￥字符串
            formattedStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: RMBSize), range: foundObj)
        }else if yuanString.length > 0{
            //设置元字符串
            formattedStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: RMBSize), range: yuanString)
        }else{
            //插入￥字符
            let RMBStr = NSMutableAttributedString(string: "￥")
            RMBStr.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSMakeRange(0, RMBStr.length))
            RMBStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: RMBSize), range: NSMakeRange(0, RMBStr.length))
            formattedStr.insert(RMBStr, at: 0)
        }

        return formattedStr
    }
}
extension UILabel {
//    MARK: 给输入的字符某个上色
//    origiString   金额原始字符
//    color         颜色

    func formatChangeColorWithOriginalString(origiString : String, colorString : String, textColor : UIColor) -> NSAttributedString {
        let formattedStr = NSMutableAttributedString(string: origiString)
        let range : Range = origiString.range(of: colorString)!
        let nsrange =  origiString.toNSRange(from: range)
        
        // 设置字符串颜色
        formattedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: nsrange)

        return formattedStr
    }
}
