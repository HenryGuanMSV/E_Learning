//
//  ELCourseMenuModel.swift
//  E_Learning
//
//  Created by Aiken on 2023/2/6.
//

import Foundation
import HandyJSON

 
// let typeDataArr = [
//     [["typeName" : "Hot", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
//     [["typeName" : "Front-End", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
//     [["typeName" : "Back-End", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
//     [["typeName" : "Android", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]],
//     ["typeName" : "iOS", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
//     [["typeName" : "Big Data", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
//     [["typeName" : "Database", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
//     [["typeName" : "English Email", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
//     [["typeName" : "User Experience", "typeDate" : ["Java","Robot","Python","Python","Html 5","Robot"]]],
// ]

struct ELCourseMenuModel : HandyJSON {
    
}

struct dataModel: HandyJSON {
    init() {
        list = []
    }
    
    var list : [[listModel]]
    
}

struct listModel : HandyJSON {
    
    var typeName : String?
    var typeDate : [String]?
    
}
