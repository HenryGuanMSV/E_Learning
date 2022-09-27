//
//  ELContentView.swift
//  E_Learning
//
//  Created by sin kwan on 2022/9/27.
//

import UIKit
import SwiftyFitsize

class ELContentView: ELBasicView {

    let titleLabelLeft = 12.0≈
    let timeLabelTop = 9.0∥
    let timeLabelBottom = 24.0∥
    
    private let titleLabel = UILabel().then() {
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.titleColor
        $0.text = Content_TIPS
    }
    
    private let timeLabel = UILabel().then() {
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(10.0)
        $0.textColor = UIColor.titleColor
        $0.text = "3h 50m  |  7Module s |  1Assessment" // 暂时写死
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
        addSubview(titleLabel)
        addSubview(timeLabel)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(titleLabelLeft)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(timeLabelTop)
            make.bottom.equalToSuperview().offset(-timeLabelBottom)
        }
    }

}
