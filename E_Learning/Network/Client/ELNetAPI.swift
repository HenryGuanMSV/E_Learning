//
//  WJContactNetAPI.swift
//  E_Learning
//
//  Created by sin on 2022/3/31.
//

import Foundation

class ELNetAPI: ELNetAPIManagers {
    /** 单例 */
    static let shared = ELNetAPI()
    
    private override init(){}
    
    override func copy() -> Any {
        return self
    }

    override func mutableCopy() -> Any {
        return self
    }
}


extension ELNetAPI {
    /** 业务接口 */
    
}
