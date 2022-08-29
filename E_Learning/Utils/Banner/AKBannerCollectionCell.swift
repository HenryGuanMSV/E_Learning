//
//  AKBannerCollectionCell.swift
//  E_Learning
//
//  Created by Aiken on 2022/8/11.
//

import UIKit

class AKBannerCollectionCell: UICollectionViewCell {
    
    private var _imageView: UIImageView?
    public var imageView: UIImageView {
        get {
            if let imageView = _imageView {
                return imageView
            }
            let imageView = UIImageView(frame: bounds)
            imageView.contentMode = .scaleAspectFill
            contentView.addSubview(imageView)
            imageView.addConstraintsAlignedToSuperview()
            
            _imageView = imageView
            
            return imageView
        }
    }
    
    public var bannerItem: AKBannerItem? {
        didSet {
            imageView.image = bannerItem?.image
        }
    }
    
}
