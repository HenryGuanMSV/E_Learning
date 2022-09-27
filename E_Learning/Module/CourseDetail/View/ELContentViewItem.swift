//
//  ELContentViewItem.swift
//  E_Learning
//
//  Created by sin kwan on 2022/9/27.
//

import UIKit
import SwiftyFitsize

enum ItemStyle {
    case arrowStyle
    case timingStlye
}

class ELContentViewItem: ELBasicView {

    let iconLeft = 12.0≈
    let iconTop = 9.0∥
    let iconWidth = 16.0≈
    
    let titleLabelLeft = 14.0≈
    
    let upArrowSize = 12.0≈
    let upArrowRight = 12.0≈
    
    let timeLabelRight = 12.0≈
    
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
        
        addSubview(icon)
        addSubview(titleLabel)
    }
    
    private func layout() {
        icon.snp.makeConstraints { make in
            make.size.equalTo(iconWidth)
            make.left.equalToSuperview().offset(iconLeft)
            make.top.equalToSuperview().offset(iconTop)
            make.bottom.equalToSuperview().offset(-iconTop)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(icon.snp.centerY)
            make.left.equalTo(icon.snp.right).offset(titleLabelLeft)
        }
    }
    
    func updateTitle(title: String) {
        titleLabel.text = title 
    }
    
    func updateStyle(style: ItemStyle) {
        upArrow.removeFromSuperview()
        timeLabel.removeFromSuperview()
        
        switch style {
        case .arrowStyle:
            addSubview(upArrow)
            upArrow.snp.remakeConstraints { make in
                make.centerY.equalTo(titleLabel.snp.centerY)
                make.size.equalTo(upArrowSize)
                make.right.equalToSuperview().offset(-upArrowRight)
            }
        case .timingStlye:
            addSubview(timeLabel)
            timeLabel.snp.remakeConstraints { make in
                make.centerY.equalTo(titleLabel.snp.centerY)
                make.right.equalToSuperview().offset(-upArrowRight)
            }
        }
    }
    
    func updateTimeStr(timeStr: String) {
        timeLabel.text = timeStr
    }
}
