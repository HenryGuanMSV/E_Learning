//
//  WJRootTabbarController.swift
//  E_Learning
//
//  Created by sin on 2022/3/31.
//

import UIKit

/** 根目录 */
class ELRootTabbarController: UITabBarController, UITabBarControllerDelegate {

    let homePageViewController = ELHomePageViewController()
//    let courseViewController = ELCourseViewController()
    var courseViewController = ELCourseViewController()
    let myViewController = ELMyViewController()

    deinit {
        print("ELRootTabbarController销毁")
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tabbar背景色
        self.tabBar.backgroundColor = .tabbarBGColor
        // 清空背景图片
        UITabBar.appearance().backgroundImage = UIImage()
        // 去除顶部分割线
        UITabBar.appearance().shadowImage = UIImage()
        // 设置点击时颜色
        self.tabBar.tintColor = .tabbarSelectColor
        
        // 代理方法
        self.delegate = self
        courseViewController = UIStoryboard(name: "ELCourseViewController", bundle: nil).instantiateViewController(withIdentifier: "CourseViewController")  as! ELCourseViewController
        
        setupRootViewController()
    }
    
    /** 视图展示完成 */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /** 初始化tabbar */
    fileprivate func setupRootViewController() {
        setTabbarState(homePageViewController, HOME_TABBAR_NAME, "tabbar_chat_enabled", "tabbar_chat")
        
//        courseViewController.pushToPage(vc: <#T##UIViewController#>)
        setTabbarState(courseViewController, COURSE_TABBAR_NAME, "tabbar_contact_enabled", "tabbar_contact")
        setTabbarState(myViewController, MY_TABBAR_NAME, "tabbar_me_enabled", "tabbar_me")

    }
    
    /** 设置tabbar信息 */
    fileprivate func setTabbarState(_ viewController : UIViewController, _ title : String, _ defaultImg : String, _ selectImg : String) {
        viewController.title = title
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: defaultImg)
        viewController.tabBarItem.selectedImage = UIImage(named: selectImg)

        let meNavigation = NavigationViewController(rootViewController: viewController)

        // 暂不加载未选中的
        addChild(meNavigation)
    }
    
    // MARK: - UITabBarControllerDelegate
    /** 每次点击tabBarItem后触发这个方法 */
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(viewController.title ?? "")
        if viewController.title == "Course" {
            
        }
    }
    
    /** 监控浅色 or 暗黑模式变化 */
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
    }
}

/// Wrapping RTRootNavigationController
protocol WrappingNavigationController: UIViewController {}
extension WrappingNavigationController {
    var wrappingNavigationController: NavigationViewController {
        return NavigationViewController(rootViewController: self)
    }
    var noWrappingNavigationController: NavigationViewController {
        return NavigationViewController(rootViewControllerNoWrapping: self)
    }
}
extension ELRootTabbarController: WrappingNavigationController {}
extension ELHomePageViewController: WrappingNavigationController {}
extension ELCourseViewController: WrappingNavigationController {}
extension ELMyViewController: WrappingNavigationController {}
