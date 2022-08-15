//
//  ELBasicViewController.swift
//  E_Learning
//
//  Created by sin on 2022/3/31.
//

import UIKit
import SnapKit
import SHFullscreenPopGestureSwift
import SwiftyFitsize
import RxSwift
import RxCocoa

struct NaviBarConfig {
    let size = NAVI_SIZE
    let colors = [UIColor.colorWithString("#6C84BF").cgColor, UIColor.colorWithString("#1F49AF").cgColor]
    let darkColors = [UIColor.colorWithString("#323232").cgColor, UIColor.colorWithString("#141414").cgColor]
    let points = [CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 0)]
    let locations = [1.0, 0.0]
}

/** 父类 */
class ELBasicViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    // MARK: 销毁
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ELSystemTools.shared.topViewController = self
        // 主背景色
        self.view.backgroundColor = .mainColor
//        // 设置导航栏背景色 - 如 UIImage 为空则透明
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: ""), for: UIBarMetrics.default)
        // 设置状态栏的坐标位置变化
        self.navigationController?.navigationBar.isTranslucent = true
        // 给导航条设置一个空的背景图 使其透明化
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        // 去除导航条透明后导航条下的黑线
        self.navigationController?.navigationBar.shadowImage = UIImage()
//        // 状态栏字体颜色
//        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // 返回按钮
        self.setBackNavigationBarWithAction(action: #selector(popViewControllerAnimated))
        // 隐藏导航条
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    open func setupNavBarMainStyle() {
        let config = NaviBarConfig()
        if #available(iOS 13, *) {
            let app = UINavigationBarAppearance()
            app.configureWithOpaqueBackground() // 重置背景和阴影颜色
            app.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.whiteColor
            ]
            app.backgroundColor = .naviColor // 设置导航栏背景色
            let clearImage = UIImage(color: .clear, size: NAVI_SIZE)
            app.shadowImage = clearImage // 设置导航栏下边界分割线透明
            navigationController?.navigationBar.scrollEdgeAppearance = app // 带scroll滑动的页面
            navigationController?.navigationBar.standardAppearance = app // 常规页面
        } else {
            let naviImage = UIImage.colorGradientImage(size: config.size, colors: config.colors, points: config.points, locations: config.locations)
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.whiteColor
            ]
            navigationController?.navigationBar.barTintColor = .whiteColor
            navigationController?.navigationBar.setBackgroundImage(naviImage, for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        self.navigationController?.navigationBar.isTranslucent = false
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: UInt(NaviHeight))
    }

    
    /** 视图即将出现 */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ELSystemTools.shared.topViewController = self
    }

    /** 视图已在屏幕上渲染完成 */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    /** 视图即将移除 */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    /** 视图已被移除 */
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    /** 内存管理调配 */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /** 状态栏颜色 */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    // MARK: 系统级方法
    /** 返回上一级 */
    @objc func popViewControllerAnimated() {
        if ((self.navigationController) != nil) {
            let count : Int = self.navigationController?.viewControllers.count ?? 0
            if (count > 1) {
                self.navigationController?.popViewController(animated: true)
                return
            }
        }
        // use for override
        if ((self.presentingViewController) != nil) {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /** 清空导航条左边Item */
    func cleanLeftNavigationItem () {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationItem.hidesBackButton = true
    }

    /** 清空导航条右边Item */
    func cleanRightNavigationItem() {
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
        self.navigationItem.hidesBackButton = true
    }
    
    /** 强制回到第一个界面 */
    func mandatoryBackFirstController() {
//        let navigationSelf : UINavigationController = self.navigationController ?? UINavigationController()
//        let viewControllers : Array<UIViewController> = [navigationSelf.viewControllers.first ?? WJRootViewController()]
//        navigationSelf.setViewControllers(viewControllers, animated: true)
        
        self.navigationController?.popToRootViewController(animated: true)
        ELSystemTools.shared.topViewController = self.navigationController?.topViewController
    }

    /** 刷新段 */
    func refreshTabViewSections(tableView : UITableView, index : Int) {
        let indexSet : NSIndexSet = NSIndexSet.init(index: index)
        tableView.reloadSections(indexSet as IndexSet, with: UITableView.RowAnimation.none)
    }

    /** 刷新行 */
    func refreshTableViewRow(tableView : UITableView, row : Int, section : Int) {
        let indexPath : IndexPath = IndexPath.init(row: row, section: section)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
    
    /** 设置左边的按钮带文字 */
    func setLeftNavigationItemText(imageName: String = "tag_return", text: String?) -> UILabel {
        navigationItem.title = ""
        return setLeftNavigationItemText(imageName: imageName, text: text ?? "", action: #selector(popViewControllerAnimated))
    }

    /** 监控浅色 or 暗黑模式变化 */
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        /**
             如果开启了暗黑，将所有window的overrideUserInterfaceStyle设置为
             UIUserInterfaceStyleDark。
             如果关闭了暗黑，将所有window的overrideUserInterfaceStyle设置为
             UIUserInterfaceStyleLight。
         */
//        self.view.backgroundColor = .mainColor
//        self.navigationController?.navigationBar.barTintColor = .mainColor
    }
}

//MARK: Push/Present OR Pop
extension ELBasicViewController {
    @objc func pushToPage(vc:UIViewController) {
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentToPage(vc:UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    
}
