//
//  WJCheckUtil.swift
//  E_Learning
//
//  Created by Sin on 2022/4/11.
//

import Foundation

// 匹配 [验证手机号码]
let MATCHING_PHONE_NUMBER = "^(1[0-9])\\d{9}$"
// 匹配 [Email地址]
let MATCHING_EMAIL = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*.\\w+([-.]\\w+)*$"
// 匹配 [密码]
let MATCHING_PASSWORD = "^(?=.*\\d)(?=.*[a-zA-Z]).{8,16}$"
// 匹配 [URL]
let MATCHING_URL = "\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?"
// 匹配 [整数]
let MATCHING_PURE_NUMBER = "^([0-9])\\d{4}$"

/** 验证 */
class WJCheckUtil {
    static let shared = WJCheckUtil()
    
    private init(){}
    
    /** 手机号码格式 */
    static func isPhoneNumber(_ phone : String) -> Bool {
        return isVerification(phone, MATCHING_PHONE_NUMBER)
    }

    /** 验证邮箱 */
    static func isEMail(_ email : String) -> Bool {
        return isVerification(email, MATCHING_EMAIL)
    }
    
    /** 判断是否密码 */
    static func isPassword(_ pwd : String) -> Bool {
        return isVerification(pwd, MATCHING_PASSWORD)
    }
    
    /** 判断URL的格式是否正确 */
    static func isURL(_ url : String) -> Bool {
        return isVerification(url, MATCHING_URL)
    }

    /** 判断是否正数 */
    static func isPureNumber(_ number : String) -> Bool {
        return isVerification(number, MATCHING_PURE_NUMBER)
    }
    
    
    /** 判断银行卡 */
    static func isBankCard(_ number : String) -> Bool {
        let pattern = "^([0-9]{16}|[0-9]{19}|[0-9]{17}|[0-9]{18}|[0-9]{20}|[0-9]{21})$"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.dotMatchesLineSeparators)
        if let _ = regex.firstMatch(in: number, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, number.count)) {
            return true
        }
        return false
    }
    
    /** 身份证*/
    static func isTrueIDNumber(_ number : String) -> Bool {
       let pattern = "(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)"
       let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.dotMatchesLineSeparators)
       if let _ = regex.firstMatch(in: number, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, number.count)) {
           return true
       }
       return false

    }
    
    /** 验证规则 */
    static func isVerification(_ str : String, _ regular : String) -> Bool {
        // 获取验证信息
        let verification : NSPredicate = NSPredicate(format: "SELF MATCHES %@", regular)
        // 验证手机号码
        return verification.evaluate(with: str)
    }
}
