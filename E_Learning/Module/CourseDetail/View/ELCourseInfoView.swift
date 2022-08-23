//
//  ELCourseInfoView.swift
//  E_Learning
//
//  Created by sin on 2022/8/23.
//

import UIKit
import SwiftyFitsize

class ELCourseInfoView: ELBasicView {

    let titleLabelTop = 14.5∥
    let titleLeft = 12.0≈

    let nameViewSize = 28.0≈
    let nameViewTop = 13.0∥
    
    let smallTitleLabelLeft = 12.0≈
    
    let contentViewTop = 13.5∥
    let contentViewHeight = 120.0∥
    
    private let titleLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.titleColor
        $0.text = COURSE_INFO_TITLE
    }

    private let nameView = ELNameView(frame: CGRect(x: 0, y: 0, width: 28.0≈, height: 28.0≈)).then() {
        $0.backgroundColor = .nameViewBGColor
    }
    
    private let smallTitleLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(10.0)
        $0.textColor = UIColor.subTitleColor
        $0.text = "ZhiPeng Ni" // 暂时写死
    }

    private let contentView = UIView().then() {
        $0.backgroundColor = .nameContentViewBGColor
        $0.addDefaultCorner()
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
        addSubview(nameView)
        addSubview(smallTitleLabel)
        addSubview(contentView)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(titleLeft)
            make.top.equalToSuperview().offset(titleLabelTop)
        }
        
        nameView.snp.makeConstraints { make in
            make.size.equalTo(nameViewSize)
            make.top.equalTo(titleLabel.snp.bottom).offset(nameViewTop)
            make.left.equalTo(titleLabel.snp.left)
        }
        
        smallTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameView)
            make.left.equalTo(nameView.snp.right).offset(smallTitleLabelLeft)
        }
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(nameView.snp.bottom).offset(contentViewTop)
            make.bottom.equalToSuperview()
            make.height.equalTo(contentViewHeight)
        }
    }
}
