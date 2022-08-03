//
//  Array.swift
//  WedoTalk
//
//  Created by weiju on 2022/4/29.
//

import Foundation

extension Array {
    /** 防止数组越界 */ 
    subscript(safe index: Int) -> Element? {
        if self.count > index {
            //            return self[index]
            return (0 ..< count).contains(index) ? self[index] : nil
        } else {
            return nil
        }
    }
    subscript(index: Int, safe: Bool) -> Element? {
        if safe {
            if self.count > index {
                return self[index]
            } else {
                return nil
            }
        } else {
            return self[index]
        }
    }
    
    // 去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
    
    func uniqued<H: Hashable>(_ filter : (Element) -> H) -> [Element]{
        var result = [Element]()
        var map  = [H: Element]()
        for value in self {
            let key = filter(value)
            if map[key] == nil {
                map[key] = value
                result.append(value)
            }
//            if !result.map({filter($0)}).contains(key) {
//                result.append(value)
//            }
        }
        return result
    }
}
