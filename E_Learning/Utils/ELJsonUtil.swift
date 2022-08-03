//
//  JsonUtil.swift
//  E_Learning
//
//  Created by Sin on 2021/10/14.
//

import Foundation
import HandyJSON

/** json解析类 */
class ELJsonUtil: HandyJSON {
    required init(){}
    
    /** Json转对象 */
    static func jsonToModel(_ jsonStr : String, _ modelType : HandyJSON.Type) ->SuperOB {
        if jsonStr.isEmpty || jsonStr.count == 0 {
            #if DEBUG
                print("jsonoModel:字符串为空")
            #endif
            return SuperOB()
        }
        return modelType.deserialize(from: jsonStr) as! SuperOB
    }
    
    /** Json转数组对象 */
    static func jsonArrayToModel<T : SuperOB>(_ modelType : T.Type, _ jsonArrayStr : String) -> [T] {
        if jsonArrayStr.isEmpty || jsonArrayStr.count == 0 {
            #if DEBUG
                print("jsonToModelArray:字符串为空")
            #endif
            return []
        }
        var modelArray : [T] = []
        let data = jsonArrayStr.data(using: String.Encoding.utf8)
        let peoplesArray = try! JSONSerialization.jsonObject(with:data!, options: JSONSerialization.ReadingOptions()) as? [AnyObject]
        for people in peoplesArray! {
            modelArray.append(dictionaryToModel(modelType, people as! [String : Any]))
        }
        return modelArray
    }
    
    /** 字典转对象 */
    static func dictionaryToModel<T : SuperOB>(_ modelType : T.Type, _ dictionStr : [String : Any]) -> T {
        if dictionStr.count == 0 {
            #if DEBUG
                print("dictionaryToModel:字符串为空")
            #endif
            return T()
        }
        return modelType.deserialize(from: dictionStr) ?? T()
    }
    
    /** 对象转JSON */
    static func modelToJson(_ model : SuperOB?) -> String {
        if model == nil {
            #if DEBUG
                print("modelToJson:model为空")
            #endif
             return ""
        }
        return (model?.toJSONString())!
    }
    
    /** 对象转字典 */
//    static func modelToDictionary(_ model:SuperOB?) -> [String : Any] {
//        if model == nil {
//            #if DEBUG
//                print("modelToJson:model为空")
//            #endif
//            return [:]
//        }
//        return (model?.toJSON())!
//    }
//
    /** 对象转字典 */
    static func modelToDictionary(obj: Any, remainFeild: [String]? = nil, replace: (((label: String, value: Any)) -> (String, Any))? = nil) -> [String : Any] {
        var dict : [String : Any] = [:]
        var children : [Mirror.Child] = []
        
        if let superChildren = Mirror(reflecting: obj).superclassMirror?.children {
            children.append(contentsOf: superChildren)
        }
        
        children.append(contentsOf: Mirror(reflecting: obj).children)
        
        for child in children {
            if let key = child.label {
                if let remainFeild = remainFeild, !remainFeild.contains(key) {
                    continue
                }
                let subMirror = Mirror(reflecting: child.value)
                if let displayStyle = subMirror.displayStyle, displayStyle == .optional {
                    if subMirror.children.isEmpty {
                        continue
                    }
                }
                
                // 解析类型属性
                let subDict = modelToDictionary(obj: child.value, remainFeild: remainFeild, replace: replace)
                if subDict.isEmpty {
                    if let replaceReturn = replace?((key, child.value)) {
                        if !replaceReturn.0.isEmpty {
                            if let aryValue = replaceReturn.1 as? [Any] {
                                var dictAry : [Any] = []
                                for value in aryValue {
                                    let subDict = modelToDictionary(obj: value, remainFeild: remainFeild, replace: replace)
                                    if subDict.isEmpty {
                                        dictAry.append(value)
                                    } else {
                                        dictAry.append(subDict)
                                    }
                                }
                                dict[replaceReturn.0] = dictAry
                            } else {
                                dict[replaceReturn.0] = replaceReturn.1
                            }
                        }
                    } else {
                        if let aryValue = child.value as? [Any] {
                            var dictAry : [Any] = []
                            for value in aryValue {
                                let subDict = modelToDictionary(obj: value, remainFeild: remainFeild, replace: replace)
                                if subDict.isEmpty {
                                    dictAry.append(value)
                                } else {
                                    dictAry.append(subDict)
                                }
                            }
                            dict[key] = dictAry
                        } else {
                            dict[key] = child.value
                        }
                    }
                } else {
                    // 非基础数据类型暂时只支持label替换
                    if let replace = replace?((key, child.value)) {
                        if !replace.0.isEmpty {
                            if let someDict = subDict["some"] {
                                dict[replace.0] = someDict
                            } else {
                                dict[replace.0] = subDict
                            }
                        }
                    } else {
                        if let someDict = subDict["some"] {
                            dict[key] = someDict
                        } else {
                            dict[key] = subDict
                        }
                    }
                }
            }
        }
        
        return dict
    }
}
