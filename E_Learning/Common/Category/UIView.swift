//
//  UIView.swift
//  E_Learning
//
//  Created by sin on 2022/5/17.
//

import UIKit

extension UIView {
    func removeAllSubviews() {
        for v in self.subviews as [UIView] {
            v.removeFromSuperview()
        }
    }
    
    /** 设置view指定位置指定大小圆角 */
    func setCorners(topLeft : CGFloat, topRight : CGFloat, bottomLeft : CGFloat, bottomRight : CGFloat) {
        if topLeft == 0 && topRight == 0 && bottomRight == 0 && bottomLeft == 0 {
            return
        }
        let maxX = self.bounds.maxX
        let maxY = self.bounds.maxY
        // 获取中心点
        let topLeftCenter = CGPoint(x: topLeft, y: topLeft)
        let topRightCener = CGPoint(x: maxX-topRight, y: topRight)
        let bottomRightCenter = CGPoint(x: maxX-bottomRight, y: maxY-bottomRight)
        let bottomLeftCenter = CGPoint(x: bottomLeft, y: maxY-bottomLeft)
        let shaperLayer = CAShapeLayer()
        let mutablePath = CGMutablePath()
        // 左上
        mutablePath.addArc(center: topLeftCenter, radius: topLeft, startAngle: .pi, endAngle: .pi/2*3, clockwise:false)
        // 右上
        mutablePath.addArc(center: topRightCener, radius: topRight, startAngle: .pi/2*3, endAngle:0, clockwise:false)
        // 右下
        mutablePath.addArc(center: bottomRightCenter, radius: bottomRight, startAngle:0, endAngle:CGFloat(Double.pi/2), clockwise:false)
        // 左下
        mutablePath.addArc(center: bottomLeftCenter, radius: bottomLeft, startAngle: .pi/2, endAngle: .pi, clockwise:false)
        shaperLayer.path = mutablePath
        self.layer.mask = shaperLayer
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}

protocol NibLoadable {}
extension UIView: NibLoadable {}
extension NibLoadable where Self: UIView {
    static func xibView(_ nibName: String? = nil) -> Self {
        return Bundle.main.loadNibNamed(nibName ?? "\(self)", owner: nil, options: nil)?.last! as! Self
    }
    
    static func nib(bundle: Bundle? = nil) -> UINib {
        return UINib.init(nibName: "\(self)", bundle: bundle)
    }
}
