//
//  ELCourseInfoTitleView.swift
//  E_Learning
//
//  Created by sin on 2022/8/23.
//

import UIKit
import SwiftyFitsize

class ELCourseInfoTitleView: ELBasicView {

    let titleLabelTop = 11.0∥
    let titleLeft = 12.0≈

    let downArrowRight = 12.0≈
    let downArrowSize = 16.0≈
    let downArrowBottom = 12.0∥

    
    private let titleLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.titleColor
        $0.text = COURSE_INFO_CONTENT_TITLE
    }
    
    private let downArrow = UIImageView(image: UIImage(named: "icon／arrowDown32")).then() {
        $0.contentMode = .scaleAspectFit
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
        addSubview(downArrow)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(titleLabelTop)
            make.left.equalToSuperview().offset(titleLeft)
        }
        
        downArrow.snp.makeConstraints { make in
            make.size.equalTo(downArrowSize)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().offset(-downArrowRight)
            make.bottom.equalToSuperview().offset(-downArrowBottom)
        }
    }
}
