//
//  ELCourseLabel.swift
//  E_Learning
//
//  Created by sin kwan on 2022/9/27.
//

import UIKit
import SwiftyFitsize

class ELCourseLabel: ELBasicView {

    private let titleLabel = UILabel().then() {
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(10.0)
        $0.textColor = UIColor.titleColor
        $0.text = "Vue.js" // 暂时写死
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
        backgroundColor = .flagBGColor
        layer.cornerRadius = 21 * 0.5
        addSubview(titleLabel)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
