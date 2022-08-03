//
//  SuperOB.swift
//  E_Learning
//
//  Created by Sin on 2021/10/12.
//

import Foundation
import HandyJSON

/** 超类 */
class SuperOB : HandyJSON {
    required init() {}
     
    /** 状态ID, 200成功, 其它失败 */
    var code : Int64?
    /** 登录返回信息 */
    var data : NSObject?
    /** 描述信息 */
    var msg : String?
    
    /** 获取model所有的key */
    func allkeys() -> Array<String> {
        var array : Array<String>? = []
        Mirror(reflecting: self).children.forEach { (child) in
//            print(child.label ?? "") // 获取字段名
//            print(child.value)
//            print(type(of: child.value)) // 获取字段类型
            array?.append(child.label ?? "")
        }
        
        return array ?? []
    }
    
    /** 获取model的字典 */
    func allDictionary() -> Dictionary<String, Any> {
        var dic : Dictionary<String, Any> = [:]
        Mirror(reflecting: self).children.forEach { (child) in
            if child.value is String {
                dic[child.label ?? ""] = child.value as? String ?? ""
            } else if child.value is Int {
                dic[child.label ?? ""] = child.value as? Int ?? 0
            } else if child.value is Int32 {
                dic[child.label ?? ""] = child.value as? Int32 ?? 0
            } else if child.value is Int64 {
                dic[child.label ?? ""] = child.value as? Int64 ?? 0
            } else if child.value is Bool {
                dic[child.label ?? ""] = child.value as? Bool ?? false
            } else {
                dic[child.label ?? ""] = child.value
            }
        }
        
        return dic
    }
    
    /** 自定义解析规则，日期数字颜色，如果要指定解析格式，子类实现重写此方法即可 */
    func mapping(mapper: HelpingMapper) {
//        mapper <<<
//            date <-- CustomDateFormatTransform(formatString: "yyyy-MM-dd")
//
//        mapper <<<
//            decimal <-- NSDecimalNumberTransform()
//
//        mapper <<<
//            url <-- URLTransform(shouldEncodeURLString: false)
//
//        mapper <<<
//            data <-- DataTransform()
//
//        mapper <<<
//            color <-- HexColorTransform()
      }
}
