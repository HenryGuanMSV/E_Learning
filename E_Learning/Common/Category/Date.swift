//
//  Date.swift
//  WedoTalk
//
//  Created by bruce on 2021/10/21.
//

import UIKit

/** 时间扩展类 */
extension Date {
    /** 时间戳转日期
        Parameter timeInterval: 时间戳
        Returns: 结果
     */
    static func timeString(timeInterval: TimeInterval) -> String{
        // 如果服务端返回的时间戳精确到毫秒，需要除以1000,否则不需要
        let date = getNowDateFromatAnDate(Date(timeIntervalSince1970: timeInterval/1000))
        
        let formatter = DateFormatter()
        if date.isToday() {
            //是今天
            formatter.dateFormat = "今天HH:mm"
            return formatter.string(from: date)
            
        } else if date.isYesterday() {
            //是昨天
            formatter.dateFormat = "昨天HH:mm"
            return formatter.string(from: date)
        } else if date.isSameWeek() {
            //是同一周
            let week = date.weekdayStringFromDate()
            formatter.dateFormat = "\(week)HH:mm"
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter.string(from: date)
        }
    }
    
    /** 是否今天 */
    func isToday() -> Bool {
        let calendar = Calendar.current
        // 当前时间
        let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date() )
        // self
        let selfComponents = calendar.dateComponents([.day, .month, .year], from: self as Date)
        
        return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.day == nowComponents.day)
    }
    
    /** 是否昨天 */
    func isYesterday() -> Bool {
        let calendar = Calendar.current
        // 当前时间
        let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date() )
        // self
        let selfComponents = calendar.dateComponents([.day, .month, .year], from: self as Date)
        let cmps = calendar.dateComponents([.day], from: selfComponents, to: nowComponents)
        
        if nowComponents.year == selfComponents.year && nowComponents.month == selfComponents.month {
            return cmps.day == 1
        }
        return false
    }
    
    /** 是否明天 */
    func isTomorrow() -> Bool {
        let calendar = Calendar.current
        // 当前时间
        let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date() )
        // self
        let selfComponents = calendar.dateComponents([.day, .month, .year], from: self as Date)
        let cmps = calendar.dateComponents([.day], from: selfComponents, to: nowComponents)
        if nowComponents.year == selfComponents.year && nowComponents.month == selfComponents.month {
            return cmps.day == -1
        }
        return false
    }
    
    /** 是否同一周 */
    func isSameWeek() -> Bool {
        let calendar = Calendar.current
        // 当前时间
        let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date() )
        // self
        let selfComponents = calendar.dateComponents([.weekday, .month, .year], from: self as Date)
        
        return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.weekday == nowComponents.weekday)
    }
    
    /** 返回星期 */
    func weekdayStringFromDate() -> String {
        let weekdays:NSArray = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar.init(identifier: .gregorian)
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.weekday], from: self as Date)
        return weekdays.object(at: theComponents.weekday!) as! String
    }
    
    /** 根据本地时区转换 */
    static func getNowDateFromatAnDate(_ anyDate: Date?) -> Date {
        //设置源日期时区
        let sourceTimeZone = NSTimeZone(abbreviation: "UTC+8")
        //或GMT
        //设置转换后的目标日期时区
        let destinationTimeZone = NSTimeZone.local as NSTimeZone
        //得到源日期与世界标准时间的偏移量
        var sourceGMTOffset: Int? = nil
        if let aDate = anyDate {
            sourceGMTOffset = sourceTimeZone?.secondsFromGMT(for: aDate)
        }
        //目标日期与本地时区的偏移量
        var destinationGMTOffset: Int? = nil
        if let aDate = anyDate {
            destinationGMTOffset = destinationTimeZone.secondsFromGMT(for: aDate)
        }
        //得到时间偏移量的差值
        let interval = TimeInterval((destinationGMTOffset ?? 0) - (sourceGMTOffset ?? 0))
        //转为现在时间
        var destinationDateNow: Date? = nil
        if let aDate = anyDate {
            destinationDateNow = Date(timeInterval: interval, since: aDate)
        }
        return destinationDateNow!
    }
    
    /** 判断传入的时间在当前时间之前还是之后 之后为true，之前为false */
    static func isExceedCurrentTime(time : String) -> Bool {
        if time.isEmpty {
            return false
        }
        
        // 当前时间戳
        let timestamp = Date().timeIntervalSince1970
        // 秒级时间戳
//        let timeStamp2 = Int(timestamp)
        // 毫秒级时间戳
//        let timeStamp3 = CLongLong(round(timestamp * 1000))
        let timeStamp3 = Int64(round(timestamp * 1000))
        let timer = Int64(time)
        
        // 当前时间 - 传入时间，正数：已过当前时间，负数：超过当前时间
        let result = timeStamp3 - timer!
        if result < 0 {
            return true
        }
        
        return false
    }
    
    /** 获取当前时间 */
    static func Now(format : String) -> String {
        let timeInterval = Date().timeIntervalSince1970
        let date = Date.init(timeIntervalSince1970: timeInterval)
        // 创建一个时间格式化对象
        let dateFormatte = DateFormatter()
        // 设定时间的格式
        dateFormatte.dateFormat = format.isEmpty ? "YYYY-MM-dd HH:mm:ss" : format
        
        return dateFormatte.string(from: date)
    }
}
