//
//  ELProgressView.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/16.
//

import UIKit
import SwiftyFitsize

class ELProgressView: ELBasicView {
    
    let titleLabelTop = 17.0∥
    let titleLeft = 12.0≈

    let statusLabelTop = 16.5∥
    
    let timeLabelRight = 12.0≈
    
    let progressViewTop = 16.0∥
    let progressViewHeight = 4.0∥
    let progressViewBottom = 24.0∥
    
    
    private let titleLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.titleColor
        $0.text = PROGREE_VIEW_TITLE
    }

    private let statusLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.subTitleColor
        $0.text = PROGREE_STATUS_TITLE
    }
    
    private let timeLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.subTitleAlphaColor
        $0.text = "3h 46m 53s" // 暂时写死
    }

    lazy var progressView: RCGradientProgressView = {
        $0.layer.cornerRadius = 4
        $0.progressCornerRadius = 4
        $0.backgroundColor = .grayColor
        $0.progressColors = [.colorWithString("#3774F3"), .colorWithString("#AD05FB")]
        $0.animationDuration = 2.0
        $0.setProgress(0.7, animated: false)
        return $0
    }(RCGradientProgressView(frame: CGRect(x: 0, y: 0, width: 335.0≈, height: 4.0∥)))
    
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
        addSubview(statusLabel)
        addSubview(timeLabel)
        addSubview(progressView)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(titleLeft)
            make.top.equalToSuperview().offset(titleLabelTop)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(statusLabelTop)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(statusLabel.snp.centerY)
            make.right.equalToSuperview().offset(-timeLabelRight)
        }
        
        progressView.snp.makeConstraints { make in
            make.width.equalTo(335.0≈)
            make.centerX.equalToSuperview()
            make.height.equalTo(progressViewHeight).priority(999)
            make.top.equalTo(statusLabel.snp.bottom).offset(progressViewTop)
            make.bottom.equalToSuperview().offset(-progressViewBottom)
        }
    }
}
