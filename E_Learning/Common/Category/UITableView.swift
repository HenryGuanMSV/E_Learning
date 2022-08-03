//
//  UITableView.swift
//  WedoTalk
//
//  Created by bruce on 2021/10/20.
//

import UIKit
import MJRefresh

/** tableview扩展类 */
extension UIScrollView {
    /** 下拉刷新 -- 默认 */
    func refrederHeadDefault(target : Any) {
        self.mj_header = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: #selector(loadDownData))
    }
    
    /** 下拉刷新 -- 自动回弹的文字 */
    func refrederHeadAutoResilienceText(target : Any) {
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadOverData）
        self.mj_header = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: #selector(loadDownData))
//        // 设置了底部inset
//        self.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
//        // 忽略底部inset
//        self.mj_header?.ignoredScrollViewContentInsetTop = NAVIGATIONBAR_HEIGHT
    }
    
    /** 下拉刷新 -- 自定义文字 */
    func refrederHeadCustomRefresh(target : Any) {
        return refrederHeadCustomRefresh(target: target, idleTitle: "", refreshBefore: "", refreshing: "")
    }
    func refrederHeadCustomRefresh(target : Any, idleTitle : String, refreshBefore : String, refreshing : String) {
        let header = MJRefreshNormalHeader.init(refreshingTarget: target, refreshingAction: #selector(loadDownData))
        // 自定义
        header.setTitle(idleTitle.isEmpty ? idleTitle : "Pull down to refresh", for: MJRefreshState.idle)
        // 刷新前文字
        header.setTitle(refreshBefore.isEmpty ? refreshBefore : "Release to re fresh", for: MJRefreshState.pulling)
        // 刷新时文字
        header.setTitle(refreshing.isEmpty ? refreshing : "Loading", for: MJRefreshState.refreshing)
        
        header.stateLabel?.font = UIFont.systemFont(ofSize: 15)
        header.lastUpdatedTimeLabel?.font = UIFont.systemFont(ofSize: 14)
        
        header.stateLabel?.textColor = .red
        header.lastUpdatedTimeLabel?.textColor = .blue
        
        self.mj_header = header
    }
    
    /** 下拉刷新 -- 动画 */
    func refrederHeadAnimation(target : Any) {
        let header = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: #selector(loadDownData))
        
        // 设置自动切换透明度（在导航栏下面自动隐藏）
        header.isAutomaticallyChangeAlpha = true
        // 隐藏时间
        header.lastUpdatedTimeLabel?.isHidden = true
        // 隐藏状态
        header.stateLabel?.isHidden = true
        
        self.mj_header = header
    }
    
    /** 上拉刷新 -- 默认 */
    func refrederFootDefault(target : Any) {
        self.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: target, refreshingAction: #selector(loadOverData))
    }
    
    /** 上拉刷新 -- 动画 */
    func refrederFootAnimation(target : Any) {
        
    }
    
    /** 上拉刷新 -- 自动回弹的文字 */
    func refrederFootAutoResilienceText(target : Any) {
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadOverData）
        self.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: target, refreshingAction: #selector(loadOverData))
//        // 设置了底部inset
//        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // 忽略底部inset
        self.mj_footer?.ignoredScrollViewContentInsetBottom = 0
    }
    
    /** 上拉刷新 -- 自动回弹的动画 */
    func refrederFootAutoResilienceAnimation(target : Any) {
        
    }
    
    /** 上拉刷新 -- 自定义文字 */
    func refrederFootCustomText(target : Any) {
        return refrederFootCustomText(target: target, idleTitle: "", refreshBefore: "", refreshing: "")
    }
    func refrederFootCustomText(target : Any, idleTitle : String, refreshBefore : String, refreshing : String) {
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadOverData方法）
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: target, refreshingAction: #selector(loadOverData))
        
        // 自定义设置
        // Set title
        footer.setTitle(idleTitle.isEmpty ? idleTitle : "Click or drag up to refresh", for: MJRefreshState.idle)
        // 刷新前文字
        footer.setTitle(refreshBefore.isEmpty ? refreshBefore : "Loading more ...", for: MJRefreshState.refreshing)
        // 刷新时文字
        footer.setTitle(refreshing.isEmpty ? refreshing : "No more data", for: MJRefreshState.noMoreData)

        // 设置字体
        footer.stateLabel?.font = UIFont.systemFont(ofSize: 17)

        // 设置颜色
        footer.stateLabel?.textColor = .blue
        
        // 设置footer
        self.mj_footer = footer;
    }
    
    /** 下拉刷新 */
    @objc func loadDownData() {
        print("子类实现下拉刷新")
    }

    /** 上拉刷新 */
    @objc func loadOverData() {
        print("子类实现上拉刷新")
    }
}
