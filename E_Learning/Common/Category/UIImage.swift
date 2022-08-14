//
//  UIImage.swift
//  E_Learning
//
//  Created by sin on 2021/12/21.
//

import UIKit

extension UIImage {
    /** 初始化纯色Image */
    class func imageWithColor(_ color : UIColor, _ size : CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context : CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /** 切换正常 or 暗黑模式 */
    class func imageLightDark(light: String, dark: String) -> UIImage {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIImage(named: dark) ?? UIImage(named: "")!
            } else {
                return UIImage(named: light) ?? UIImage(named: "")!
            }
        } else {
            return UIImage(named: light) ?? UIImage(named: "")!
        }
    }
    
    /** 构造渐变颜色 */
    class func colorGradientImage(size: CGSize, colors: [CGColor], points: [CGPoint] = [.zero, CGPoint(x: 1, y: 1)], locations: [Double] = [0, 1.0]) -> UIImage? {
        guard points.count > 0 else { return nil }
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.colors = colors
        
        var numberLocations: [NSNumber] = []
        locations.forEach { it in
            numberLocations.append(NSNumber(floatLiteral: it))
        }
        gradientLayer.locations = numberLocations
        
        gradientLayer.startPoint = points.first!
        
        gradientLayer.endPoint = points.last!
        
        var image: UIImage? = UIImage()
        UIGraphicsBeginImageContext(size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /** 生成二维码*/
    class func createUIImageFromCIImage(image: CIImage, size: CGFloat) -> UIImage {
        let extent = image.extent.integral
        let scale = min(size / extent.width, size / extent.height)
            
        /// Create bitmap
        let width: size_t = size_t(extent.width * scale)
        let height: size_t = size_t(extent.height * scale)
        let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmap: CGContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 1)!
       
        ///
        let context = CIContext.init()
        let bitmapImage = context.createCGImage(image, from: extent)
        bitmap.interpolationQuality = .none
        bitmap.scaleBy(x: scale, y: scale)
        bitmap.draw(bitmapImage!, in: extent)
            
        let scaledImage = bitmap.makeImage()
        return UIImage.init(cgImage: scaledImage!)
    }
    
    /** 生成二维码*/
    class func generate(from string : String) -> UIImage? {
         let context = CIContext()
         let data = string.data(using: String.Encoding.utf8)

         if let filter = CIFilter(name: "CIQRCodeGenerator") {
             filter.setValue(data, forKey: "inputMessage")
             let transform = CGAffineTransform(scaleX: 7, y: 7)
             if let output = filter.outputImage?.transformed(by: transform), let cgImage = context.createCGImage(output, from: output.extent) {
                 return UIImage(cgImage: cgImage)
             }
         }
         return nil
     }
    
    /** 生成条形码*/
    class func generateBarCodes(messgae:NSString,width:CGFloat,height:CGFloat) -> UIImage {
        var returnImage:UIImage?
        if (messgae.length > 0 && width > 0 && height > 0){
            let inputData:NSData? = messgae.data(using: String.Encoding.utf8.rawValue)! as NSData
            // CICode128BarcodeGenerator
            let filter = CIFilter.init(name: "CICode128BarcodeGenerator")!
            filter.setValue(inputData, forKey: "inputMessage")
            var ciImage = filter.outputImage!
            let scaleX = width/ciImage.extent.size.width
            let scaleY = height/ciImage.extent.size.height
            ciImage = ciImage.transformed(by: CGAffineTransform.init(scaleX: scaleX, y: scaleY))
            returnImage = UIImage.init(ciImage: ciImage)
        }else {
            returnImage = nil;
        }
        return returnImage!
    }
    
    /** View生成图片*/
    class func getGeneratePictures(size : CGSize, currentView : UIView) -> UIImage {
         UIGraphicsBeginImageContextWithOptions(size, true, 1.0)
         currentView.layer.render(in: UIGraphicsGetCurrentContext()!)
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         return image!
     }
}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
