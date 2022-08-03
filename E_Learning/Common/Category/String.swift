//
//  String.swift
//  WedoTalk
//
//  Created by bruce on 2021/10/12.
//

import Foundation
import CommonCrypto
import UIKit

/** String类扩展 */
extension String {
    /** check string cellection is whiteSpace */ 
    var isBlank : Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
    
    /** 字符串转字典 */
    func toDictionary() -> [String : Any] {
        var result = [String : Any]()
        guard !self.isEmpty else { return result }
        
        guard let dataSelf = self.data(using: .utf8) else {
            return result
        }
        
        if let dic = try? JSONSerialization.jsonObject(with: dataSelf,
                           options: .mutableContainers) as? [String : Any] {
            result = dic
        }
        return result
    }
    
    /** 字符串转Data */
    func toData() -> [UInt8] {
        if self.isBlank == true {
            return []
        }
        let data = self.data(using: .utf8)!
        return [UInt8](data)
    }
    
    // Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    // Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    /** des加密 */
    func desEncrypt(key : String, iv : String? = "", options : Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = key.data(using: String.Encoding.utf8),
            let data = self.data(using: String.Encoding.utf8),
            let cryptData    = NSMutableData(length: Int((data.count)) + kCCBlockSizeDES) {


            let keyLength              = size_t(kCCKeySizeDES)
            let operation: CCOperation = UInt32(kCCEncrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmDES)
            let options:   CCOptions   = UInt32(options)



            var numBytesEncrypted :size_t = 0

            let cryptStatus = CCCrypt(operation,
                                      algoritm,
                                      options,
                                      (keyData as NSData).bytes, keyLength,
                                      iv,
                                      (data as NSData).bytes, data.count,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)

            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
                return base64cryptString

            }
            else {
                return nil
            }
        }
        return nil
    }
    
    /** desc解密 */
    func desDecrypt(key : String, iv : String? = "", options : Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = key.data(using: String.Encoding.utf8),
           let data = NSData(base64Encoded: self, options: .ignoreUnknownCharacters),
           let cryptData    = NSMutableData(length: Int((data.length)) + kCCBlockSizeDES) {
            
            let keyLength              = size_t(kCCKeySizeDES)
            let operation: CCOperation = UInt32(kCCDecrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmDES)
            let options:   CCOptions   = UInt32(options)
            
            var numBytesEncrypted :size_t = 0
            
            let cryptStatus = CCCrypt(operation,
                                      algoritm,
                                      options,
                                      (keyData as NSData).bytes, keyLength,
                                      iv,
                                      data.bytes, data.length,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let unencryptedMessage = String(data: cryptData as Data, encoding:String.Encoding.utf8)
                return unencryptedMessage
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    /** aes加密 */
    func aesEncrypt(key : String, iv : String? = "", options : Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = key.data(using: String.Encoding.utf8),
            let data = self.data(using: String.Encoding.utf8),
            let cryptData    = NSMutableData(length: Int((data.count)) + kCCBlockSizeAES128) {


            let keyLength              = size_t(kCCKeySizeAES128)
            let operation: CCOperation = UInt32(kCCEncrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options:   CCOptions   = UInt32(options)

            var numBytesEncrypted :size_t = 0

            let cryptStatus = CCCrypt(operation,
                                      algoritm,
                                      options,
                                      (keyData as NSData).bytes, keyLength,
                                      iv,
                                      (data as NSData).bytes, data.count,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)

            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
                return base64cryptString

            }
            else {
                return nil
            }
        }
        return nil
    }
    
    /** aes解密 */
    func aesDecrypt(key : String, iv : String? = "", options : Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = key.data(using: String.Encoding.utf8),
           let data = NSData(base64Encoded: self, options: .ignoreUnknownCharacters),
           let cryptData    = NSMutableData(length: Int((data.length)) + kCCBlockSizeAES128) {
            
            let keyLength              = size_t(kCCKeySizeAES128)
            let operation: CCOperation = UInt32(kCCDecrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options:   CCOptions   = UInt32(options)
            
            var numBytesEncrypted :size_t = 0
            
            let cryptStatus = CCCrypt(operation,
                                      algoritm,
                                      options,
                                      (keyData as NSData).bytes, keyLength,
                                      iv,
                                      data.bytes, data.length,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let unencryptedMessage = String(data: cryptData as Data, encoding:String.Encoding.utf8)
                return unencryptedMessage
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    /** md5加密 */
    var md5: String {
        let str = self.cString(using : String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)

        let hash = NSMutableString()

        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }

        result.deallocate()
        return hash as String
    }
    
    func decode() -> [String: Any] {
//        let segments = self.components(separatedBy: ".")
//        return decodeJWTPart(segments[1]) ?? [:]
        return decodeJWTPart(self) ?? [:]
    }
    
    /** JWT */
    func jwtDecode(_ value: String) -> Data? {
        var base64 = value.replacingOccurrences(of: "-",with: "+").replacingOccurrences(of: "_",with: "/")

        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength),withPad: "=",startingAt: 0)
            base64 = base64 + padding
        }

        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
    func decodeJWTPart(_ value: String) -> [String: Any]? {
        guard let bodyData = jwtDecode(value),let json = try? JSONSerialization.jsonObject(with: bodyData,options: []),let payload = json as? [String: Any] else {
            return nil
        }
     
        return payload
    }
    
    /**
        指定关键字高亮
        keyWords: 关键字
        color: 高亮颜色
     */
    func highlight(keyWords: String?, highlightColor color: UIColor) -> NSAttributedString {
        let string : String = self
        let attributeString = NSMutableAttributedString(string: string)
        
        guard let keyWords = keyWords else { return attributeString }
        
        let attribute : [NSAttributedString.Key: Any] = [.foregroundColor: color]
        // 需要改变的文本
        let ranges = ranges(of: keyWords, options: .caseInsensitive)
        for range in ranges where range.location + range.length <= string.count {
            attributeString.addAttributes(attribute, range: range)
        }
        
        return attributeString
    }
    
    /**
        查找字符串中子字符串的NSRange
        substring: 子字符串
        options: 匹配选项
        locale: 本地化
        return: 子字符串的NSRange数组
     */
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [NSRange] {
        var ranges: [Range<Index>] = []
        while let range = range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
            ranges.append(range)
        }
        // [range]转换为[NSRange]返回
        return ranges.compactMap({NSRange($0, in: self)})
    }
    
    /** range转换为NSRange */
    func toNSRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    /** 获取文字的宽高 */
    func getStringSize(font: UIFont, viewSize: CGSize) -> CGSize {
        let rect = self.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin,.truncatesLastVisibleLine,.usesFontLeading,.usesDeviceMetrics], attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size
    }
}
//MARK:---------- 汉字转拼音
extension String {
    func isHaveChinese() -> Bool {
        for ch in self.unicodeScalars {
            if (0x4e00 < ch.value  && ch.value < 0x9fff) { return true } // 中文字符范围：0x4e00 ~ 0x9fff
        }
        return false
    }
    
    /// 将中文字符串转换为拼音
    ///
    /// - Parameter hasBlank: 是否带空格（默认不带空格）
    func transformToPinyin(hasBlank: Bool = false) -> String {
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false) // 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false) // 去掉音标
        let pinyin = stringRef as String
        return hasBlank ? pinyin : pinyin.replacingOccurrences(of: " ", with: "")
    }
    
    /// 获取中文首字母
    ///
    /// - Parameter lowercased: 是否小写（默认大写）
    func transformToPinyinHead(lowercased: Bool = false) -> String {
        let pinyin = self.transformToPinyin(hasBlank: true).capitalized // 字符串转换为首字母大写
        var headPinyinStr = ""
        for ch in pinyin {
            if ch <= "Z" && ch >= "A" {
                headPinyinStr.append(ch) // 获取所有大写字母
            }else {
                headPinyinStr.append("#")
            }
        }
        return lowercased ? headPinyinStr.lowercased() : headPinyinStr
    }
    
    /// 获取中文首字母
    ///
    /// - Parameter lowercased: 是否小写（默认大写）
    func transformToPinyinHeadFirst(lowercased: Bool = false) -> String {
        let pinyin = self.transformToPinyin(hasBlank: true).capitalized // 字符串转换为首字母大写
        var headPinyinStr = ""
        for ch in pinyin {
            if ch <= "Z" && ch >= "A" {
                headPinyinStr.append(ch) // 获取所有大写字母
                break
            }else {
                headPinyinStr.append("#")
                break
            }
        }
        return lowercased ? headPinyinStr.lowercased() : headPinyinStr
    }
    
}
extension String {
    // 计算文字size
    /// - Parameters:
    ///   - font: 字体
    ///   - maxSize: 最大Size
    /// - Returns: 文本size
    func getSize(font: UIFont, maxSize: CGSize) -> CGSize {
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return self.boundingRect(with: maxSize, options: options, attributes: [NSAttributedString.Key.font: font], context: nil).size
    }
}

//MARK:---------- emoji 资源
extension String {
    func emojiLocalPath() -> String? {
        guard let indexStr = Int(self) else { return nil }
        return "[ej]pic_emojis\(indexStr)[/ej]"
    }
    func praseEmojiString() {
        
    }
}

///url截取参数成字典
extension String {
    /// 从String中截取出参数
    var urlParameters: [String: AnyObject]? {
        // 截取是否有参数
        guard let urlComponents = NSURLComponents(string: self), let queryItems = urlComponents.queryItems else {
            return nil
        }
        // 参数字典
        var parameters = [String: AnyObject]()
        
        // 遍历参数
        queryItems.forEach({ (item) in
            
            // 判断参数是否是数组
            if let existValue = parameters[item.name], let value = item.value {
                // 已存在的值，生成数组
                if var existValue = existValue as? [AnyObject] {
                    
                    existValue.append(value as AnyObject)
                } else {
                    parameters[item.name] = [existValue, value] as AnyObject
                }
                
            } else {
                
                parameters[item.name] = item.value as AnyObject
            }
        })
        
        return parameters
    }
}
