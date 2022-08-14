//
//  Dictionary.swift
//  E_Learning
//
//  Created by sin on 2021/10/13.
//

import Foundation

/** 字典扩展 */
extension Dictionary {
    /** 字典转字符串 */
    func toJsonString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        guard let str = String(data: data, encoding: .utf8) else {
            return nil
        }
        return str
    }
}
