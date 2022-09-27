//
//  UIColor.swift
//  E_Learning
//
//  Created by sin on 2021/10/9.
//

import UIKit

/** 渐变方式 */
enum GradientChangeDirection : Int {
    /** 自定义 */
    case GradientChangeDirectionCustom = 0
    /** 水平渐变 */
    case GradientChangeDirectionLevel = 1
    /** 垂直渐变 */
    case GradientChangeDirectionVertical = 2
    /** 向下对角线渐变 */
    case GradientChangeDirectionUpwardDiagonalLine = 3
    /** 向上对角线渐变 */
    case GradientChangeDirectionDownDiagonalLine = 4
}

/** 自定义颜色 */
extension UIColor {
    
    /** RGB自定义颜色 */
    class func RGBColor(red : CGFloat, green : CGFloat, blue : CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
    }
    
    /** # 0x 自定义颜色 */
    class func colorWithString(_ hex : String) -> UIColor {
        return colorWithString(hex, alpha:1)
    }
    
    class func colorWithString(_ hex : String, alpha : CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        } else if (cString.hasPrefix("0X") || cString.hasPrefix("0x")) {
            cString =  ((cString as NSString).substring(from: 2) as NSString).substring(to: 6)
        } else {
            return black
        }
        
        if ((cString as NSString).length != 6) {
            return black
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    /** 颜色渐变 */
    class func bm_colorGradientChangeWithSize(frame : CGRect, direction : GradientChangeDirection, startColor : UIColor, endColor : UIColor, locations : [NSNumber], startPoint : CGPoint, endPoint : CGPoint) -> UIColor {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = !locations.isEmpty ? locations : [0.0, 1.0]
        
        /**
         （0，0）：左上角
         （0，1）：左下角
         （1，0）：右上角
         （1，1）：右下角
         */
        switch (direction) {
            case .GradientChangeDirectionCustom:
                gradientLayer.startPoint = startPoint
                gradientLayer.endPoint = endPoint
                break
            case .GradientChangeDirectionLevel:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
                break
            case .GradientChangeDirectionVertical:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
                break
            case .GradientChangeDirectionUpwardDiagonalLine:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
                break
            case .GradientChangeDirectionDownDiagonalLine:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
                break
        }
        
        var image: UIImage? = UIImage()
        UIGraphicsBeginImageContext(frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        return UIColor.init(patternImage: image!)
    }
    
    /** 构造渐变颜色 */
    class func bm_colorGradient(size: CGSize, colors: [CGColor], points: [CGPoint] = [.zero, CGPoint(x: 1, y: 1)], locations: [Double] = [0, 1.0]) -> UIColor {
        guard points.count > 0 else { return .clear }
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.colors = colors
        
        var numberLocations: [NSNumber] = []
        locations.forEach { it in
            numberLocations.append(NSNumber(floatLiteral: it))
        }
        gradientLayer.locations = numberLocations
        
        gradientLayer.startPoint = points.first!
        
        gradientLayer.endPoint = points.last!
        
        var image: UIImage? = UIImage()
        UIGraphicsBeginImageContext(size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        return UIColor.init(patternImage: image!)
    }
    
    class func colorLightDark(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init(dynamicProvider: { trainCollection in
//                if WJUserInfoManager.shared.userModel.colorMode == 0 {
                    if trainCollection.userInterfaceStyle == .dark {
                        return dark
                    } else {
                        return light
                    }
//                } else if WJUserInfoManager.shared.userModel.colorMode == 2 {
//                    return dark
//                } else {
//                    return light
//                }
            })
        }
        
        return light
    }
    
    /** 主色 - xxx */
    class var mainColor : UIColor {
        return UIColor.colorWithString("#EEF1F3")
    }
    
    /** 白色 - #FFFFFF */
    class var whiteColor : UIColor {
        return UIColor.colorWithString("#FFFFFF")
    }
    
    /** 阴影黑色 - #000000 */
    class var shadowColor : UIColor {
        return UIColor.colorWithString("#000000", alpha: 0.1)
    }
    
    /** 灰色 - #E4E7E8 */
    class var grayColor : UIColor {
        return UIColor.colorWithString("#E4E7E8")
    }
    
    /** tabbar背景色 - #FFFFFF */
    class var tabbarBGColor : UIColor {
        return UIColor.colorWithString("#FFFFFF")
    }

    /** tabbar选中色 - #FFFFFF */
    class var tabbarSelectColor : UIColor {
        return UIColor.colorWithString("#007CC3")
    }
    
    /** nav背景色 - #172A34 */
    class var navBgColor : UIColor {
        return UIColor.colorWithString("#172A34")
    }
    
    /** 标题颜色 - #040148 */
    class var titleColor: UIColor {
        return UIColor.colorWithString("#040148")
    }

    /** 副标题颜色 - #151641 */
    class var subTitleColor: UIColor {
        return UIColor.colorWithString("#151641")
    }

    /** 半透明副标题颜色 - #151641 */
    class var subTitleAlphaColor: UIColor {
        return UIColor.colorWithString("#151641", alpha: 0.6)
    }
    
    /** 姓名背景颜色 -  #EEDBEE */
    class var nameViewBGColor: UIColor {
        return UIColor.colorWithString("#EEDBEE")
    }

    /** 半透明背景颜色 */
    class var nameContentViewBGColor: UIColor {
        return UIColor.colorWithString("#EEF1F3", alpha: 0.8)
    }

    /** 标签背景颜色 */
    class var flagBGColor: UIColor {
        return UIColor.colorWithString("#30C883")
    }


    
    class var naviColor : UIColor {
        let config = NaviBarConfig()
        let naviColorLight = UIColor.bm_colorGradient(size: config.size, colors: config.colors, points: config.points, locations: config.locations)
        let naviColorDark = UIColor.bm_colorGradient(size: config.size, colors: config.darkColors, points: config.points, locations: config.locations)
        return self.colorLightDark(light: naviColorLight, dark: naviColorDark)
    }
}


