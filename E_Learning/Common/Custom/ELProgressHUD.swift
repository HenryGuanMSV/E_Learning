//
//  ELProgressHUD.swift
//  E_Learning
//
//  Created by sin on 2021/11/06.
//

import UIKit
import MBProgressHUD
import NVActivityIndicatorView

/** 转动样式 */
enum ELProgressHUDStyle : Int {
    /** 无 */
    case none = 0
    /** 请求时默认样式 */
    case loadingState = 1
}

/** HUD */
class ELProgressHUD: NSObject {
    static let shared = ELProgressHUD()
    private override init(){}
    
    /** loading样式 - 默认请求会有loading，每次使用完后都会默认置为默认样式，如果不需要转圈则请求前设置样式为.none */
    var loadingStyle : ELProgressHUDStyle? = ELProgressHUDStyle.loadingState
    /** 第三方loading动画 */
    private var activityIndicatorView : NVActivityIndicatorView?
    
    // MARK: - 消息
    func showMessage(_ message : String) {
        show(text: message, textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: "", view: ELWindow!, mode: .text, afterDelay: 0)
    }
    
    func showMessage(message : String, toView : UIView) {
        show(text: message, textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: "", view: toView, mode: .text, afterDelay: 0)
    }
    
    func showMessage(message : String, isShowBottom : Bool) {
        show(text: message, textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: "", view: ELWindow!, mode: .text, afterDelay: 0, isShowBottom: isShowBottom)
    }
    
    func showMessage(message : String, toView : UIView, isShowBottom : Bool) {
        show(text: message, textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: "", view: toView, mode: .text, afterDelay: 0, isShowBottom: isShowBottom)
    }
    
    // MARK: - 显示成功提示
    func showSuccess(_ success : String) {
        show(text: success, textColor: nil, font: nil, backgroundColor: nil, margin: 40, icon: "img_progress_correct", view: ELWindow!, mode: .text, afterDelay: 0)
    }
    func showSuccess(success : String, icon : String) {
        show(text: success, textColor: nil, font: nil, backgroundColor: nil, margin: 40, icon: "img_progress_correct", view: ELWindow!, mode: .customView, afterDelay: 0)
    }
    func showSuccess(success : String, toView : UIView) {
        show(text: success, textColor: nil, font: nil, backgroundColor: nil, margin: 40, icon: "img_progress_correct", view: toView, mode: .text, afterDelay: 0)
    }
    func showSuccess(success : String, icon : String, toView : UIView) {
        show(text: success, textColor: nil, font: nil, backgroundColor: nil, margin: 40, icon: "img_progress_correct", view: toView, mode: .customView, afterDelay: 0)
    }
    
    // MARK: - 显示错误提示
    func showError(_ error : String) {
        show(text: error, textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: "", view: ELWindow!, mode: .text, afterDelay: 0)
    }
    func showError(error : String, icon : String) {
        show(text: error, textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: icon.isBlank == false ? icon : "", view: ELWindow!, mode: .customView, afterDelay: 0)
    }
    func showError(error : String, toView : UIView) {
        show(text: error, textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: "", view: toView, mode: .text, afterDelay: 0)
    }
    func showError(error : String, icon : String, toView : UIView) {
        show(text: error, textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: icon.isBlank == false ? icon : "", view: toView, mode: .customView, afterDelay: 0)
    }

    // MARK: - 显示加载进度 圈圈提示
    func showProgress() {
        show(text: "", textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: "", view: ELWindow!, mode: .customView, afterDelay: 7)
    }
    func showProgress(msg : String) {
        show(text: msg, textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: "", view: ELWindow!, mode: .customView, afterDelay: 7)
    }
    func showProgress(msg : String, toView : UIView) {
        show(text: msg, textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: "", view: toView, mode: .customView, afterDelay: 7)
    }
    func showProgress(msg : String, icon : String, toView : UIView) {
        show(text: msg, textColor: nil, font: nil, backgroundColor: nil, margin: 20, icon: icon.isBlank == false ? icon : "", view: toView, mode: .customView, afterDelay: 7)
    }

    // MARK: - 系统默认菊花
    func showSystemDefaultProgress() {
        // 如果已有弹框，先消失
        hideHUD()
        // 快速显示一个提示信息
        let progressHUD : MBProgressHUD = MBProgressHUD.showAdded(to: ELWindow!, animated: true)
        progressHUD.mode = .indeterminate
        progressHUD.bezelView.style = .solidColor
        // 提示框背景颜色
        progressHUD.bezelView.color = UIColor.clear
        progressHUD.backgroundView.color = UIColor.clear
        // 隐藏时候从父控件中移除
        progressHUD.removeFromSuperViewOnHide = true
        // 多长时间消失
        progressHUD.hide(animated: true, afterDelay: 3)
    }

    // MARK: - 圆形进度条
    func showProgressCircular(_ msg : String) -> MBProgressHUD {
        // 如果已有弹框，先消失
        hideHUD()
        
        // 快速显示一个提示信息
        let progressHUD : MBProgressHUD = MBProgressHUD.showAdded(to: ELWindow!, animated: true)
        progressHUD.mode = .annularDeterminate
        // 提示字 内容
        progressHUD.label.text = msg.isBlank == false ? msg : ""
        // 提示字 大小        12.0f  框架默认的
        progressHUD.label.font = UIFont.systemFont(ofSize: 15)
        // 提示字体颜色             框架默认颜色
        progressHUD.label.textColor = UIColor.white
        // 提示框背景颜色      框架 默认 [UIColor whiteColor]
        progressHUD.bezelView.color = UIColor.black
//        progressHUD.backgroundView.color = UIColor.init(white: 0, alpha: 0.2)
        // 纯色背景样式
        progressHUD.bezelView.style = .solidColor
        // 圆角
        progressHUD.bezelView.layer.cornerRadius = 12
        // 提示框边界大小      20.f框架默认值
        // 边界
        progressHUD.margin = 20
        // 隐藏时候从父控件中移除
        progressHUD.removeFromSuperViewOnHide = true
        // 多长时间消失
        progressHUD.hide(animated: true, afterDelay: 3)
        
        return progressHUD
    }
    
    // MARK: - 加载样式
    /** 默认loadding */
    func showDefaultLoadding() {
        showLoadingStyle(msg: "", type: .lineSpinFadeLoader, isInfinite: false)
    }
    
    func showLoadingStyle(msg : String, type : NVActivityIndicatorType, isInfinite : Bool? = false, delay : TimeInterval? = 3) {
        // 如果已有弹框，先消失
        hideHUD()
        
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: type, color: UIColor.white, padding: 0)
        
        // 快速显示一个提示信息
        let progressHUD : MBProgressHUD = MBProgressHUD.showAdded(to: ELWindow!, animated: true)
        progressHUD.mode = .customView
        progressHUD.customView = activityIndicatorView
        // 提示字 内容
        progressHUD.label.text = msg.isBlank == false ? msg : ""
        // 提示字 大小        12.0f  框架默认的
        progressHUD.label.font = UIFont.systemFont(ofSize: 15)
        // 提示字体颜色             框架默认颜色
        progressHUD.label.textColor = UIColor.white
        // 提示框背景颜色
        progressHUD.bezelView.color = UIColor.black
//        progressHUD.backgroundView.color = UIColor.clear
        // 纯色背景样式
        progressHUD.bezelView.style = .solidColor
        // 圆角
        progressHUD.bezelView.layer.cornerRadius = 12
        // 提示框边界大小      20.f框架默认值
        progressHUD.margin = 50
        // 隐藏时候从父控件中移除
        progressHUD.removeFromSuperViewOnHide = true
        // 多长时间消失
        if isInfinite == false {        
            progressHUD.hide(animated: true, afterDelay: delay ?? 3)
        }
        
        // 显示动画
        activityIndicatorView?.startAnimating()
    }
    
    // MARK: - 隐藏提示
    /** 隐藏提示 */
    func hideHUD() {
        if activityIndicatorView != nil {
            activityIndicatorView?.stopAnimating()
        }
        MBProgressHUD.hide(for: ELWindow!, animated: true)
    }
    
    func hideHUD(view : UIView) {
        if activityIndicatorView != nil {
            activityIndicatorView?.stopAnimating()
        }
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    /**
     *  设置 HNProgressHUD  基本属性的方法体
     *  @param  text            提示内容
     *  @param  font            提示内容字体大小                默认    [UIFont boldSystemFontOfSize:13.0f]
     *  @param  textColor       提示字体颜色                   默认    [UIColor blackColor]
     *  @param  backgroundColor 提示框背景颜色                  默认    [UIColor whiteColor]
     *  @param  margin          提示框边界大小                 想默认 填 0    20.f框架默认值
     *  @param  icon            MBProgressHUDModeCustomView 模式下 自定义图片
     *  @param  view            显示的view
     *  @param  mode            显示的模式
     *  @param  delay           显示的消失时间                 默认1秒
     */
    func show(text : String, textColor : UIColor? = nil, font : UIFont? = nil, backgroundColor : UIColor? = nil, margin : CGFloat, icon : String, view : UIView, mode : MBProgressHUDMode, afterDelay : CGFloat) {
        return self.show(text: text, textColor: textColor, font: font, backgroundColor: backgroundColor, margin: margin, icon: icon, view: view, mode: mode, afterDelay: afterDelay, isShowBottom: false)
    }
    
    func show(text : String, textColor : UIColor? = nil, font : UIFont? = nil, backgroundColor : UIColor? = nil, margin : CGFloat, icon : String, view : UIView, mode : MBProgressHUDMode, afterDelay : CGFloat, isShowBottom : Bool) {
        // 如果已有弹窗，先消失
        MBProgressHUD.hide(for: view, animated: true)
        
        // 提示信息对象
        let progressHUD : MBProgressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        // 将view调整到父视图的最上面
        view.bringSubviewToFront(progressHUD)
        if isShowBottom == true {
            // 底部显示
            progressHUD.offset = CGPoint(x: 0, y: MBProgressMaxOffset)
        }
        
        if mode == .indeterminate {
            /** 默认模式,使用系统自带的指示器 ,不能显示进度,只能不停地转呀转*/
            progressHUD.mode = .indeterminate
        } else if mode == .determinate {
            /** 用饼图显示进度 */
            progressHUD.mode = .determinate
        } else if mode == .determinateHorizontalBar {
            /** 进度条 */
            progressHUD.mode = .determinateHorizontalBar
        } else if mode == .annularDeterminate {
            /** 圆环 */
            progressHUD.mode = .annularDeterminate
        } else if mode == .customView {
            /** 自定义视图 */
            progressHUD.mode = .customView
            progressHUD.customView = UIImageView.init(image: UIImage.init(named: icon))
//            if icon.isBlank == false {
//                startAnimation(progressHUD: progressHUD)
//            }
        } else  {
            /** 只显示文字 */
            progressHUD.mode = .text
        }
        
        // 提示字 内容
        progressHUD.label.text = text.isBlank == true ? "" : text
        progressHUD.label.numberOfLines = 0
        // 提示字体颜色
        progressHUD.label.textColor = textColor == nil ? UIColor.white : textColor
        // 提示字 大小
        progressHUD.label.font = font == nil ? UIFont.systemFont(ofSize: 15) : font
        // 提示框背景颜色
        progressHUD.bezelView.color = backgroundColor == nil ? UIColor.colorWithString("#333333") : backgroundColor
        // 纯色背景样式
        progressHUD.bezelView.style = .solidColor
        // 圆角
        progressHUD.bezelView.layer.cornerRadius = 12
//        // 遮挡整个背景色
//        progressHUD.backgroundView.color = UIColor.black
        if icon.isBlank == false {
            progressHUD.margin = 40
        } else {
            // 提示框边界大小    20默认值
            let defaultMargin : CGFloat = margin > 0 ? margin : 20.0
            progressHUD.margin = defaultMargin
        }
        // 隐藏的时候从父控件移除
        progressHUD.removeFromSuperViewOnHide = true
        // 多少秒之后消失 默认1秒
        let delay = afterDelay > 0 ? afterDelay : 3
        progressHUD.hide(animated: true, afterDelay: delay)
    }
    
    /** 开始旋转 */
    func startAnimation(progressHUD : MBProgressHUD) {
        let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        rotationAnimation.duration = 1;
        // 无穷大
        rotationAnimation.repeatCount = Float.infinity
        progressHUD.customView?.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}
