//
//  WJNetAPIManagers.swift
//  E_Learning
//
//  Created by sin on 2021/10/14.
//

import Foundation
import HandyJSON
import Alamofire
import CommonCrypto
import Moya
import UIKit
/** code类型 */
enum ELCodeType : Int {
    /**
         200    操作成功    全局
         500    操作失败    全局
     */
    case success = 200
    case failure = 500
}

/** 网络请求管理 */
class ELNetAPIManagers: NSObject {
    // code
    private var codeType : ELCodeType?
//    var updateBlock : () -> Void = {}
//    /** 域名列表 */
//    var domainNameArray : Array<String> = []
//    /** 域名存储 */
//    var domainName : String = "\(DOMAIN_BASE_URL)"
//    /** 获取过缓存域名 */
//    var isGetCacheDomainName : Bool = false
    
    override func copy() -> Any {
        return self
    }

    override func mutableCopy() -> Any {
        return self
    }

    // Optional
    func reset() {
        // Reset all properties to default value : 重置数据
    }
}

extension ELNetAPIManagers {

    /** 分解response superOB */
    func resolveRequest<T : SuperOB>(_ result: Result<Moya.Response, MoyaError>, success : @escaping (T) -> Void, message : ((String) -> Void)? = nil, failure : @escaping ((String) -> Void)) {
        switch result {
        case let .success(response):
            // 获取服务器返回的结果
            let data = dataConversion(responseStr: String(data: response.data, encoding: .utf8) ?? "", message: message)
            
            if codeType == .success {
                // 转换数据类型
                let dic : Dictionary<String, Any> = data as? Dictionary<String, Any> ?? [:]
                // 判断是否为空
                if let object = T.deserialize(from: dic) {
                    // 传参出去接收
                    success(object)
                    break
                }
            } else {
                if message == nil {
                    failure("")
                }
            }
            break
        case let .failure(error):
            #if DEBUG
            print("请求失败: \(error.localizedDescription)")
            #endif
            failure(error.localizedDescription)
        }
    }
    
    /** 分解response */
    func resolveRequest<T : SuperOB>(_ result: Result<Moya.Response, MoyaError>, success : @escaping ([T]) -> Void, message : ((String) -> Void)? = nil, failure : @escaping ((String) -> Void)) {
        switch result {
        case let .success(response):
            // 获取服务器返回的结果
            let data = dataConversion(responseStr: String(data: response.data, encoding: .utf8) ?? "", message: message)
            
            if codeType == .success {
                // 转换数据类型
                let array : [Any] = data as? [Any] ?? []
                // 判断是否为空
                if let object = [T].deserialize(from: array) {
                    // 传参出去接收
                    success(object as? [T] ?? [])
                    break
                }
            } else {
                if message == nil {
                    failure("")
                }
            }
            break
        case let .failure(error):
            #if DEBUG
            print("请求失败: \(error.localizedDescription)")
            #endif
            failure(error.localizedDescription)
        }
    }
    
    /** 分解responese返回字典 */
    func resolveRequest(_ result: Result<Moya.Response, MoyaError>, success : @escaping (Dictionary<String, Any>) -> Void, message : ((String) -> Void)? = nil, failure : @escaping ((String) -> Void)) {
        switch result {
        case let .success(response):
            // 获取服务器返回的结果
            let data = dataConversion(responseStr: String(data: response.data, encoding: .utf8) ?? "", message: message)
            
            if codeType == .success {
                // 转换数据类型
                let dic : Dictionary<String, Any> = data as? Dictionary<String, Any> ?? [:]
                success(dic)
            } else {
                if message == nil {
                    failure(data as? String ?? "")
                }
            }
            break
        case let .failure(error):
            failure(error.localizedDescription)
            break
        }
    }
    
    /** 分解responese返回数组<字典> */
    func resolveRequest(_ result: Result<Moya.Response, MoyaError>, success : @escaping (Array<Dictionary<String, Any>>) -> Void, message : ((String) -> Void)? = nil, failure : @escaping ((String) -> Void)) {
        switch result {
        case let .success(response):
            // 获取服务器返回的结果
            let data = dataConversion(responseStr: String(data: response.data, encoding: .utf8) ?? "", message: message)
            
            if codeType == .success {
                // 转换数据类型
                let array : Array<Dictionary<String, Any>> = data as? Array<Dictionary<String, Any>> ?? []
                // 判断是否为空
                success(array)
            } else {
                if message == nil {
                    failure("")
                }
            }
            break
        case let .failure(error):
            #if DEBUG
            print("请求失败: \(error.localizedDescription)")
            #endif
            failure(error.localizedDescription)
            break
        }
    }
    
    /** 分解responese返回字符串 */
    func resolveRequest(_ result: Result<Moya.Response, MoyaError>, success : @escaping (String) -> Void, message : ((String) -> Void)? = nil, failure : @escaping ((String) -> Void)) {
        switch result {
        case let .success(response):
            // 获取服务器返回的结果
            let data = dataConversion(responseStr: String(data: response.data, encoding: .utf8) ?? "", message: message)
            
            if codeType == .success {
                // 转换数据类型
                let value : String = data as? String ?? ""
                success(value)
            } else {
                if message == nil {
                    failure("")
                }
            }
            break
        case let .failure(error):
            failure(error.localizedDescription)
            break
        }
    }
    
    /** 分解responese返回Int */
    func resolveRequest(_ result: Result<Moya.Response, MoyaError>, success : @escaping (Int) -> Void, message : ((String) -> Void)? = nil, failure : @escaping ((String) -> Void)) {
        switch result {
        case let .success(response):
            // 获取服务器返回的结果
            let data = dataConversion(responseStr: String(data: response.data, encoding: .utf8) ?? "", message: message)
            
            if codeType == .success {
                // 转换数据类型
                let value : Int = data as? Int ?? 0
                success(value)
            } else {
                if message == nil {
                    failure("")
                }
            }
            break
        case let .failure(error):
            failure(error.localizedDescription)
            break
        }
    }

    /** 数据转换 */
    private func dataConversion(responseStr : String, message : ((String) -> Void)? = nil) -> Any {
        let data : Dictionary<String, Any> = responseStr.toDictionary()

        if data.count == 0 {
            DispatchQueue.main.async {
                ELProgressHUD.shared.showError(NETWORK_ANOMALIES)
            }
            
            if message != nil {
                message?(NETWORK_ANOMALIES)
            }
            return ""
        }
        
        // 判断是否包含code ... 服务器报错就不给code😭😭😭😭😭
        if data.keys.contains("code") {
            // 获取code编码
            let code : ELCodeType = ELCodeType(rawValue: data["code"] as? Int ?? 500) ?? .failure
            codeType = code

            if code == .success {
                return data["data"] as Any
            }

        }
        
        let msg : String = data["msg"] as? String ?? ""
        if message != nil {
            message?(msg)
        } else {
            if msg.isBlank == false {
                DispatchQueue.main.async {
                    ELProgressHUD.shared.showError(msg)
                }

            }
        }
        return msg
    }
}
