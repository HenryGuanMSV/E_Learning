//
//  RCGradientProgressView.swift
//  E_Learning
//
//  Created by sin on 2022/8/23.
//

import UIKit

class RCGradientProgressView: ELBasicView {

    //进度条完成部分的渐变颜色，设置单个为纯色，设置多个为渐变色
    public var progressColors: [UIColor] = [.blue] {
        didSet {
            if progressColors.count == 0 {
                gradientLayer.colors = nil
            } else if progressColors.count == 1 {
                let color = progressColors[0]
                gradientLayer.colors = [color, color].map { $0.cgColor }
            } else {
                gradientLayer.colors = progressColors.map { $0.cgColor }
            }
        }
    }

    //进度条完成部分的圆角半径
    public var progressCornerRadius: CGFloat = 0 {
        didSet {
            maskLayer.cornerRadius = progressCornerRadius
        }
    }
    
    //渐变Layer
    public let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.anchorPoint = .zero
        layer.startPoint = .zero
        layer.endPoint = CGPoint(x: 1.0, y: 0.0)
        return layer
    }()

    //动画持续时间
    public var animationDuration: TimeInterval = 0.3
    
    //动画时间函数
    public var timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: .default)
    
    private var privateProgress: Float = 0
    private let maskLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.cgColor

        return layer
    }()
    
    //当前进度
    public var progress: Float {
        get {
            return privateProgress
        }
        set {
            setProgress(newValue, animated: false)
        }
    }
        
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
        
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
        
    func setupUI() {
        let color = progressColors[0]
        gradientLayer.colors = [color, color].map { $0.cgColor }
        gradientLayer.mask = maskLayer
        layer.insertSublayer(gradientLayer, at: 0)
    }
        
    open override func layoutSubviews() {
        super.layoutSubviews()
        // 没有内间距
        gradientLayer.frame = bounds.inset(by: .zero)
        var bounds = gradientLayer.bounds
        bounds.size.width *= CGFloat(progress)
        maskLayer.frame = bounds
    }
        
    public func setProgress(_ progress: Float, animated: Bool) {
        let validProgress = min(1.0, max(0.0, progress))
        if privateProgress == validProgress {
            return
        }
        privateProgress = validProgress
        
        //动画时长
        var duration = animated ? animationDuration : 0
        if duration < 0 {
            duration = 0
        }
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setAnimationTimingFunction(timingFunction)
        
        //更新maskLayer的frame
        var bounds = self.gradientLayer.bounds
        bounds.size.width *= CGFloat(validProgress)
        self.maskLayer.frame = bounds
        
        CATransaction.commit()
    }
}
