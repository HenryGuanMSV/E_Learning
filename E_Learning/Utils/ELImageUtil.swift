//
//  WJImageUtil.swift
//  E_Learning
//
//  Created by Sin on 2021/11/22.
//

import UIKit

class ELImageUtil: NSObject {
    static let shard = ELImageUtil()
    private override init(){}
    
    /** 使用颜色填充图片 */
    func imageWithColor(color : UIColor, rect: CGRect = CGRect(x:0, y:0, width:1, height:1)) -> UIImage {
        // 描述矩形 rect
        
        // 开启位图上下文
        UIGraphicsBeginImageContext(rect.size)
        // 获取位图上下文
        let context = UIGraphicsGetCurrentContext()
        // 使用color演示填充上下文
        context?.setFillColor(color.cgColor)
        // 渲染上下文
        context!.fill(rect)
        // 从上下文中获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 结束上下文
        UIGraphicsEndImageContext()
        return image!
    }
    
    /** 压缩图片至指定大小，是否裁剪成正方形 */
    static func compressImageQuality(_ image: UIImage?, _ limit: Int = 0, _ isUseSquareSize: Bool = false) -> UIImage? {
        guard let image = image,
               limit > 0 else {
            return image
        }
 
        var resultImage = image
        if isUseSquareSize {
            //计算最终尺寸
            let ratio = 1.0
            let size = resultImage.size
            var newSize: CGSize = .zero
            if size.width / size.height > ratio {
                newSize = CGSize(width: size.height * ratio, height: size.height)
            } else {
                newSize = CGSize(width: size.width, height: size.width / ratio)
            }
         
            ////图片绘制区域
            var rect = CGRect.zero
            rect.size.width  = size.width
            rect.size.height = size.height
            rect.origin.x    = (newSize.width - size.width ) / 2.0
            rect.origin.y    = (newSize.height - size.height ) / 2.0
             
            //绘制并获取最终图片
            UIGraphicsBeginImageContext(newSize)
            resultImage.draw(in: rect)
            resultImage = UIGraphicsGetImageFromCurrentImageContext() ?? resultImage
            UIGraphicsEndImageContext()
        }
        
        guard var data = resultImage.pngData() else {
            return resultImage
        }
        
        if data.count < limit {
            return resultImage
        }

        let lastDataLength = 0
        var compress: CGFloat = 1.0
        while data.count > limit &&
                data.count != lastDataLength,
                compress > 0.1 {
            compress *= 0.75
            
            let s1 = resultImage.size
            let size = CGSize(width: s1.width * compress, height: s1.height * compress)
            
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext() ?? resultImage
            data = resultImage.pngData() ?? Data()
            UIGraphicsEndImageContext()
        }
        
        return resultImage
    }
}
