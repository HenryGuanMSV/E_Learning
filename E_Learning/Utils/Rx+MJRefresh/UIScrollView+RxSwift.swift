//
//  UIScrollView+RxSwift.swift
//  E_Learning
//
//  Created by Sin on 2022/5/24.
//

import RxSwift
import RxCocoa
import MJRefresh

/// 供ViewModel使用
enum MJRefreshAction {
    /// 开始刷新
    case beginRefresh
    /// 停止刷新
    case stopRefresh
    /// 开始加载更多
    case begainLoadmore
    /// 停止加载更多
    case stopLoadmore
    /// 显示无更多数据
    case showNomoreData
    /// 重置无更多数据
    case resetNomoreData
    /// 数据加载中
    case loading
}

// MARK:- Refresh
extension Reactive where Base: UIScrollView {
    /// 执行的操作类型
    var refreshAction:Binder<MJRefreshAction> {
        return Binder(base) { (target, action) in
            switch action {
            case .beginRefresh:
                if let header =  target.mj_header {
                    header.beginRefreshing()
                }
            case .stopRefresh:
                if let header =  target.mj_header {
                    header.endRefreshing()
                }
            case .begainLoadmore:
                if let footer =  target.mj_footer {
                    footer.beginRefreshing()
                }
            case .stopLoadmore:
                if let footer =  target.mj_footer {
                    footer.endRefreshing()
                }
            case .showNomoreData:
                if let footer =  target.mj_footer {
                    footer.endRefreshingWithNoMoreData()
                }
            case .resetNomoreData:
                if let footer =  target.mj_footer {
                    footer.resetNoMoreData()
                }
            case .loading:
                break
            }
        }
    }
}
