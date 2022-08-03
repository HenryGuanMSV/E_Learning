//
//  StringUtil.swift
//  E_Learning
//
//  Created by Sin on 2021/10/25.
//

import Foundation

class ELStringUtil: NSObject {
    
    /** 获取当前时间戳 */
    static func currentTimeStr() -> String {
        // 获取当前时间0秒后的时间
        let timeInterval = Date().timeIntervalSince1970
        // *1000 是精确到毫秒，不乘就是精确到秒
        let time = timeInterval * 1000
        return String(format: "%.0f", time)
    }
    
    /** 时间戳转时间 如：2017-4-10 17:15:10 */
    static func getTimeStrWithString(str : String) -> String {
        return getTimeStrWithString(str: str, format: "YYYY-MM-dd HH:mm:ss")
    }
    
    /** 转换时间秒 */
    static func getTimeWithString(str : String, format : String) -> String {
        let timeInterval = TimeInterval(Int(str) ?? 0)
        let date = Date.init(timeIntervalSince1970: timeInterval)
        // 创建一个时间格式化对象
        let dateFormatte = DateFormatter()
        // 设定时间的格式
        dateFormatte.dateFormat = format.isEmpty ? "YYYY-MM-dd HH:mm:ss" : format
        
        return dateFormatte.string(from: date)
    }
    
    /** 转换时间毫秒 */
    static func getTimeStrWithString(str : String, format : String) -> String {
        let timeInterval = TimeInterval(Int(str) ?? 0)
        let date = Date.init(timeIntervalSince1970: timeInterval / 1000)
        // 创建一个时间格式化对象
        let dateFormatte = DateFormatter()
        // 设定时间的格式
        dateFormatte.dateFormat = format.isEmpty ? "YYYY-MM-dd HH:mm:ss" : format
        
        return dateFormatte.string(from: date)
    }
    
    /** 时间戳转评论类型 */
    static func getTimeStrWithComment(str : String) -> String {
        let timeInterval = TimeInterval.init(Int(str)!)

        // 如果服务端返回的时间戳精确到毫秒，需要除以1000,否则不需要
        let date = Date.getNowDateFromatAnDate(Date(timeIntervalSince1970: timeInterval / 1000))

        let formatter = DateFormatter()
        if date.isToday() {
            // 今天
            formatter.dateFormat = "今天HH:mm"
            return formatter.string(from: date)
        } else if date.isYesterday() {
            // 昨天
            formatter.dateFormat = "昨天HH:mm"
            return formatter.string(from: date)
        } else if date.isTomorrow() {
            // 明天
            formatter.dateFormat = "明天HH:mm"
            return formatter.string(from: date)
        } else if date.isSameWeek() {
            // 同一周
            let week = date.weekdayStringFromDate()
            formatter.dateFormat = "\(week)HH:mm"
            return formatter.string(from: date)
        } else {
//            formatter.dateFormat = "MM月dd日"
            formatter.dateFormat = "YYYY/MM/dd"
            return formatter.string(from: date)
        }
    }
    
    /**
        距今多少天字符串
        已加入天数
        30天内显示xx天
        30天以上显示x月x天
        365天以上显示x年x月x天
     */
    static func joinedDays(_ unixTime: Int?) -> String {
        guard let unixTime = unixTime else {
            return ""
        }
        
        let s1 = Date().timeIntervalSince1970
        let s2 = Double(unixTime / 1000)
        let s3 = (s1 - s2) / Double(60*60*24)
        let days = Int(s3)
        
        let s = max(days, 1)
        if s < 30 {
            return "加入\(s)天"
        } else if s < 365 && s >= 30 {
            let months = days / 30
            let offsetDays = days - months * 30
            return "加入\(months)月\(offsetDays)天"
            
        } else {
            let years = days / 365
            let months = (days - years * 365) / 30
            let offsetDays = days - months * 30
            return "加入\(years)年\(months)月\(offsetDays)天"
        }
    }
    
    /** 手机号隐藏中间4位 */
    static func privatePhone(_ phone: String?) -> String {
        var str = phone ?? ""
        if str.count == 11 {
            str = (str as NSString).substring(with: NSMakeRange(0, 3)) + "****" + (str as NSString).substring(with: NSMakeRange(7, 4))
        }
        return str
    }
    
    /** 手机号分割空格*/
    static func textParting(_ string : String) -> String {
        var phone : String = string
        if phone.count == 11 {
            let frist = string.prefix(3)
            let second = string.dropFirst(3).prefix(4)
            let third = string.dropFirst(7).prefix(4)
           print( "\(frist) \(second) \(third)")
            phone = "\(frist) \(second) \(third)"
        }
        return phone
    }
    
    /** 格式化未读数 */
    static func formatBadge(_ badge: Int) -> String {
        (badge <= 0) ? "" : (badge > 99 ? "99+" : "\(badge)")
    }
    
    /** 传入 秒  得到 xx:xx:xx */
    static func formatVideoProgressString(seconds: Int64?, duration: Int64?) -> String {
        guard let seconds = seconds,
              let duration = duration,
              duration > 0 else {
            return "00:00"
        }

        let h = String(format: "%02ld", duration / 3600)
        let m = String(format: "%02ld", (seconds % 3600) / 60)
        let s = String(format: "%02ld", seconds % 60)
        if h == "00" {
            return "\(m):\(s)"
        }
        return "\(h):\(m):\(s)"
    }
    
    /** 传入 秒  得到  0~1 */
    static func formatVideoProgress(seconds: Int64?, duration: Int64?) -> Float {
        guard let seconds = seconds,
              let duration = duration,
              duration > 0 else {
            return 0
        }

        return Float(seconds) / Float(duration)
    }
    
    /** 传入 秒  得到  min */
    static func formatVideoMinute(duration: Int64?) -> Int64 {
        guard let duration = duration,
              duration > 0 else {
            return 0
        }
        
        return (duration / 60)
    }
    
    /** 传入byte 得到格式化文件大小 */
    static func formatVideoSize(total: Int64) -> String {
        guard total > 0 else {
            return "0MB"
        }
        
        let mb = 1024 * 1024
        
        if total <= mb {
            return "1MB"
        }
        
        let gb = 1024 * 1024 * 1024
        if total >= mb &&
            total <= gb {
            return String(format: "%.2fMB", (Double(total) / Double(mb)))
        }
        
        return String(format: "%.2fGB", (Double(total) / Double(gb)))
    }
    
    /** 传入 秒  得到  years */
    static func formatYearsString(_ any: Any?) -> String {
        if let str = any as? String {
            if let intVal = Int64(str) {
                return formatYearsString(duration: intVal)
            }
            if str.count >= 4 {
                return (str as NSString).substring(to: 4)
            }
            return ""
        }
        
        if let intVal = any as? Int64 {
            return formatYearsString(duration: intVal)
        }
        
        return ""
    }
    
    static func formatYearsString(duration: Int64?) -> String {
        guard var duration = duration else {
            return ""
        }

        duration = "\(duration)".count > "\(Int64(Date().timeIntervalSince1970))".count ? duration / 1000 : duration
        let timeInterval = TimeInterval(duration)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatte = DateFormatter()
        dateFormatte.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let str = dateFormatte.string(from: date)
        if str.count >= 4 {
            return (str as NSString).substring(to: 4)
        }
        return ""
    }
    
    /** 秒转时间 */
    static func timeStampToString(timeStamp: Int) -> String {
        // 时
        let hour = timeStamp / 3600
        let hourStr = hour > 9 ? "\(hour)" : "0\(hour)"
        // 分
        let minute = timeStamp % 3600 / 60
        let minuteStr = minute > 9 ? "\(minute)" : "0\(minute)"
        // 秒
        let second = timeStamp % 3600 % 60
        let secondStr = second > 9 ? "\(second)" : "0\(second)"
        
        if hour == 0 {
            return "\(minuteStr):\(secondStr)"
        }
        
        return "\(hourStr):\(minuteStr):\(secondStr)"
    }
    
    //指定年月的结束日期
    static func endOfMonth(year: String, month: String, returnEndTime:Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
         
        let endOfYear = calendar.date(byAdding: components,
                                      to: ELStringUtil.startOfMonth(year: year, month:month))!
        return endOfYear
    }
    
    //指定年月的开始日期
    static func startOfMonth(year: String, month: String) -> Date {
        let calendar     = NSCalendar.current
        var startComps   = DateComponents()
        startComps.day   = 1
        
        startComps.month = month.int
        startComps.year  = year.int
        let startDate = calendar.date(from: startComps)!
        return startDate
    }
    
    ///根据传入的date 获取年、月、日
    static func getDateString(_ date : Date,formatterString : String = "yyyy-MM-dd", type : String) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatterString
        
        let dateString = dateFormatter.string(from: date)
        
        switch type {
        case "year":
            return String(dateString.prefix(4))
        case "month":
            return String(dateString.dropFirst(5).prefix(2))
        case "day":
            return String(dateString.suffix(2))
        default:
            return ""
        }
    }
    
    ///字符串repalce方法
    static func kStringByReplaceString(string : String,replaceStr : String,willReplaceStr : String) -> String {
        return string.replacingOccurrences(of: replaceStr, with: willReplaceStr)
    }

    /** 中文秒转时间 */
    static func timeStampToChineseStr(timeStamp: Int) -> String {
        // 时
        let hour = timeStamp / 3600
        let hourStr = hour > 9 ? "\(hour)" : "0\(hour)"
        // 分
        let minute = timeStamp % 3600 / 60
        let minuteStr = minute > 9 ? "\(minute)" : "0\(minute)"
        // 秒
        let second = timeStamp % 3600 % 60
        let secondStr = second > 9 ? "\(second)" : "0\(second)"
        
        if hour == 0 {
            return "\(minuteStr)分\(secondStr)秒"
        }
        
        return "\(hourStr)小时\(minuteStr)分\(secondStr)秒"
    }
    
    /** 判断是否为数字*/
    static func isPurnInt(_ str: String) -> Bool {
        let scan: Scanner = Scanner(string: str)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
}

