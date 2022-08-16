//
//  ELProgressView.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/16.
//

import UIKit
import SwiftyFitsize

class ELProgressView: ELBasicView {
    
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

    private let progressView = UIProgressView(progressViewStyle: .default).then {
        $0.progress = 0.5 // 暂时写死
        $0.progressTintColor = .bm_colorGradientChangeWithSize(frame: CGRect(x: 0, y: 0, width: 335.0≈, height: 4.0∥), direction:.GradientChangeDirectionLevel, startColor: .colorWithString("#3774F3"), endColor: .colorWithString("#AD05FB"), locations: [0,1], startPoint: CGPoint(x: 0.5, y: 0.5), endPoint: CGPoint(x: 0.5, y: 0.5))
        $0.trackTintColor = .grayColor
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
        addSubview(statusLabel)
        addSubview(timeLabel)
        addSubview(progressView)
    }
    
    private func layout() {
        
    }

}
