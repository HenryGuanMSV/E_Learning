//
//  ELContentViewItem.swift
//  E_Learning
//
//  Created by sin kwan on 2022/9/27.
//

import UIKit

class ELContentViewItem: ELBasicView {

    private let icon = UIImageView(image: UIImage(named: "icon／info32")).then() {
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = UILabel().then() {
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.titleColor
        $0.text = "Vue 介绍" // 暂时写死
    }

    private let upArrow = UIImageView(image: UIImage(named: "icon／arrowTop32")).then() {
        $0.contentMode = .scaleAspectFit
    }
    
    private let timeLabel = UILabel().then() {
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(10.0)
        $0.textColor = UIColor.titleColor
        $0.text = "10m" // 暂时写死
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addDefaultCorner()
        backgroundColor = .mainColor
    }
    
    private func layout() {
        
    }
}
