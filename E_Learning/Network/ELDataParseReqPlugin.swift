//
//  ELDataParseReqPlugin.swift
//  E_Learning
//
//  Created by sin on 2022/4/19.
//

import Foundation
import Moya

final class ELDataParseReqPlugin: Moya.PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var req = request
        // header config
        let header : Dictionary<String, String> = req.allHTTPHeaderFields! // var
//        let dic : Dictionary<String, Any> = Dictionary() // var
        /*
        dic["brand"] = "iPhone"
        dic["channel"] = "iOS"
        dic["imei"] = ELSystemTools.deviceId
        dic["mac"] = ""
        dic["model"] = ELSystemTools.deviceModel
        dic["oaid"] = 3
        dic["os"] = "ios"
        dic["pkg"] = "com.xx.xxx"
        dic["smid"] = ""
        dic["os_version"] = ELSystemTools.version
        dic["versionCode"] = Int(ELSystemTools.appBuild)
        dic["versionName"] = ELSystemTools.systemName
         
        
        header["X-IM-Common"] = dic.toJsonString()
        let token : String? = ELUserInfoManager.shared.token
        if token?.isBlank == false {
            header["Authorization"] = token
        }
         */
        req.allHTTPHeaderFields = header

        // body config
        guard
            let method = request.httpMethod,
            method == "POST"
        else {
            return req
        }
        var param = [String: Any]()
        if let data = req.httpBody,
           let dict = try? JSONSerialization.jsonObject(with: data),
           let body = dict as? [String: Any]
        {
            param = body
        }
        guard
            let data = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
        else {
            return req
        }
        req.httpBody = data
        #if DEBUG
            log.debug("requset url : \(String(describing: req.url?.absoluteURL))")
            print("header : \(header)")
            print("body : \(param)")
        #endif
        return req
    }
    
    func willSend(_ request: RequestType, target: TargetType) { }
    
    // receive
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        switch result {
        case .success(let response):
            // 解密
            if let dict = try? JSONSerialization.jsonObject(with: response.data),
               let _ = dict as? [String: Any]
            {
                #if DEBUG
                let jsonstring = String(bytes: response.data, encoding: .utf8)
                log.debug("\n url---> \n \(response.request?.url?.absoluteString ?? "") \n respone---> \n \(jsonstring ?? "")")
                #endif
                let response = Response(statusCode: response.statusCode, data: response.data, request: response.request, response: response.response)
                return .success(response)
            }
        case .failure(let error):
            #if DEBUG
            log.debug(error)
            #endif
            break
        }
        return result
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) { }
}
