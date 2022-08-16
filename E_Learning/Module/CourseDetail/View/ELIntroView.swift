//
//  ELIntroView.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/16.
//

import UIKit

class ELIntroView: ELBasicView {
    
    let titleLabelTop = 25.5
    let titleLeft = 12.0

    let submitBtnWidth = 335.0
    let submitBtnHeight = 36.0
    let submitBtnTop = 26.0
    
    private let titleLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(16.0)
        $0.textColor = UIColor.titleColor
        $0.text = "Vue.js 基础框架高效果快速学习路线" // 暂时写死
    }
    
    private let submitBtn = UIButton(type: .custom).then {
        $0.backgroundColor = .bm_colorGradientChangeWithSize(frame: CGRect(x: 0, y: 0, width: scaleNum(335.0), height: scaleNum(36.0)), direction:.GradientChangeDirectionLevel, startColor: .colorWithString("#3774F3"), endColor: .colorWithString("#AD05FB"), locations: [0,1], startPoint: CGPoint(x: 0.5, y: 0.5), endPoint: CGPoint(x: 0.5, y: 0.5))
        $0.addDefaultShadow()
        $0.addDefaultCorner()
        $0.setTitle("Start", for: .normal)
        $0.setTitleColor(.whiteColor, for: .normal)
        $0.titleLabel?.font = UIFont.pingFangRegular(16)
        $0.titleLabel?.textAlignment = .center
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
        addSubview(submitBtn)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(scaleNum(titleLabelTop))
            make.left.equalToSuperview().offset(scaleNum(titleLeft))
            make.right.lessThanOrEqualTo(self.snp.right).offset(scaleNum(-titleLeft))
        }
        
        submitBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(scaleNum(submitBtnWidth))
            make.height.equalTo(scaleNum(submitBtnHeight))
            make.top.equalTo(titleLabel.snp.bottom).offset(scaleNum(submitBtnTop))
            make.bottom.lessThanOrEqualTo(self.snp.bottom).offset(scaleNum(-submitBtnTop))
        }
    }
}
