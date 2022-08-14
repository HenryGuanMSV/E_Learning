//
//  WJContactAPIClient.swift
//  E_Learning
//
//  Created by sin on 2022/3/31.
//

import Foundation
import Moya

// 没菊花
let ELContactAPIClientRequest = MoyaProvider<ELAPIClient>(plugins: [
    ELDataParseReqPlugin(),NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
])

// 有菊花
let networkActivityPlugin = NetworkActivityPlugin { (changeType, targetType) -> () in
    switch(changeType) {
    case .began:
        if ELCheckNetwork.shared.checkNetworkOnceBool() == false {
            DispatchQueue.main.async {
                ELProgressHUD.shared.showError(NETWORK_ANOMALIES)
            }
            return
        }
        DispatchQueue.main.async {
            ELProgressHUD.shared.hideHUD()
            // 转动loading
            if ELProgressHUD.shared.loadingStyle == .loadingState {
                ELProgressHUD.shared.showLoadingStyle(msg: "", type: .ballSpinFadeLoader, delay: 7)
            }
            // 转完设置默认样式
            ELProgressHUD.shared.loadingStyle = .loadingState
        }
    case .ended:
        DispatchQueue.main.async {
            ELProgressHUD.shared.hideHUD()
        }
    }
}

let ELContactAPIClientLoadingRequest = MoyaProvider<ELAPIClient>(plugins: [
    ELDataParseReqPlugin(),NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)), networkActivityPlugin
])

// 接口定义
enum ELAPIClient {
    
}

/** 聊天请求 */
extension ELAPIClient: TargetType {
    /** 请求地址 */
    var baseURL: URL {
        return URL(string: nil)!
    }
    
    /** 请求路径 */
    var path: String {
        return ""
    }
    
    /** 请求方式 */
    var method: Moya.Method {
        return .post
    }
    
    /** 请求参数 */
    var task: Task {
        return .requestPlain
    }
    
    /** 请求头 */
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}
