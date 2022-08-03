//
//  CALayer.swift
//  WedoTalk
//
//  Created by weiju on 2022/4/27.
//

import UIKit

/** 动画类型 */
enum TransitionAnimType : Int {
    case fade = 0,          /** 淡入淡出 */
    push,                   /** 推挤 */
    reveal,                 /** 揭开 */
    moveIn,                 /** 覆盖 */
    cube,                   /** 立方体 */
    suckEffect,             /** 吮吸 */
    oglFlip,                /** 翻转 */
    rippleEffect,           /** 波纹 */
    pageCurl,               /** 翻页 */
    pageUnCurl,             /** 反翻页 */
    cameraIrisHollowOpen,   /** 开镜头 */
    cameraIrisHollowClose,  /** 关镜头 */
    curlDown,               /** 下翻页 */
    curlUp,                 /** 上翻页 */
    flipFromLeft,           /** 左翻转 */
    flipFromRight,          /** 右翻转 */
    ramdom                  /** 随机 */
}

/** 动画方向 */
enum TransitionSubType : Int {
    case top = 0,           /** 上 */
    left,                   /** 左 */
    bottom,                 /** 下*/
    right,                  /** 右 */
    ramdom                  /** 随机 */
}

/** 动画进出方式 */
enum TransitionCurve : Int {
    case Default = 0,       /** 默认 */
    EaseIn,                 /** 缓进 */
    EaseOut,                /** 缓出 */
    EaseInEaseOut,          /** 缓进缓出 */
    Linear,                 /** 线性 */
    Ramdom                  /** 随机 */
}

extension CALayer {
    /** 返回动画类型 */
    private func animationType(animType: TransitionAnimType) -> String {
        // 设置转场动画类型
        let animTypeArray = ["fade", "push", "reveal", "moveIn", "cube", "suckEffect", "oglFlip", "rippleEffect", "pageCurl", "pageUnCurl", "cameraIrisHollowOpen", "cameraIrisHollowClose", "curlDown", "curlUp", "flipFromLeft", "flipFromRight", "ramdom"]
        return objectFromDataSource(array: animTypeArray, index: animType.rawValue, isRamdom: (TransitionAnimType.ramdom == animType)) as! String
    }
    
    /** 返回动画方向 */
    private func animationSubType(subType: TransitionSubType) -> String {
        let animSubTypeArray = [CATransitionSubtype.fromTop, CATransitionSubtype.fromLeft, CATransitionSubtype.fromBottom, CATransitionSubtype.fromRight]
        return objectFromDataSource(array: animSubTypeArray, index: subType.rawValue, isRamdom: (TransitionSubType.ramdom == subType)) as! String
    }
    
    /** 返回动画曲线 */
    private func animationCurve(curve: TransitionCurve) -> String {
        let animCurveArray = [CAMediaTimingFunctionName.default, CAMediaTimingFunctionName.easeIn, CAMediaTimingFunctionName.easeOut, CAMediaTimingFunctionName.easeInEaseOut, CAMediaTimingFunctionName.linear]
        return objectFromDataSource(array: animCurveArray, index: curve.rawValue, isRamdom: (TransitionCurve.Ramdom == curve)) as! String
    }
    
    /** 统一从数据返回对象 */
    private func objectFromDataSource(array: Array<Any>, index: Int, isRamdom: Bool) -> AnyObject {
        let count = array.count
        let i = isRamdom ? Int(arc4random_uniform(UInt32(count))) : index

        return array[safe:i] as AnyObject
    }
    
    /** 过渡动画 */
    func layerTransition(animTye: TransitionAnimType, subType: TransitionSubType, curve: TransitionCurve, duration: CGFloat) {
        let key = "transition"
        if self.animation(forKey: key) != nil {
            self.removeAnimation(forKey: key)
        }
        let transition = CATransition()

        // 动画时长
        transition.duration = CFTimeInterval(duration)

        // 动画类型
        transition.type = CATransitionType(rawValue: animationType(animType: animTye))

        // 动画方向
        transition.subtype = CATransitionSubtype(rawValue: animationSubType(subType: subType))

        // 缓动函数
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: animationCurve(curve: curve)))

        // 完成动画删除
        transition.isRemovedOnCompletion = true

        self.add(transition, forKey: key)
    }
}
