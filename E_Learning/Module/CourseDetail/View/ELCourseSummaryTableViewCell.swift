//
//  ELCourseSummaryTableViewCell.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/30.
//

import UIKit
import SwiftyFitsize

class ELCourseSummaryTableViewCell: ELBasicTableViewCell {

    let titleLeft = 12.0≈
    
    let contentLabelTop = 9.0∥
    
    let subLabelTop = 24.0∥
    let subLabelBottom = 35.0∥
    
    let flagLabelWidth = 48.0≈
    let flagLabelHeight = 16.0∥
    let flagLabelLeft = 12.0≈
    let flagLabelTop = 9.0∥
    let flagLabelBottom = 48.0∥
    
    private let titleLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.titleColor
        $0.text = SUMMARY_TIPS
    }
    
    private let contentLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(10.0)
        $0.textColor = UIColor.titleColor
        // 暂时写死
        $0.text = "模板语法、计算属性和侦听器、 Class 与 Style 绑定、条件渲染、列表渲染、事件处理、表单输入绑定、组件基础、样式渲染的"
    }
    
    private let subLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.titleColor
        $0.text = SUMMARY_SUB_TIPS
    }
    
    private let flagLabel = ELCourseLabel().then() {_ in
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupViews()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(subLabel)
        contentView.addSubview(flagLabel)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left).offset(titleLeft)
            make.right.lessThanOrEqualTo(contentView.snp.right).offset(-titleLeft)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(contentLabelTop)
            make.left.equalTo(titleLabel.snp.left)
            make.right.lessThanOrEqualTo(contentView.snp.right).offset(-titleLeft)
        }

        subLabel.snp.makeConstraints { make in
            make.left.equalTo(contentLabel.snp.left)
            make.top.equalTo(contentLabel.snp.bottom).offset(subLabelTop)
            make.right.lessThanOrEqualTo(contentView.snp.right).offset(-titleLeft)
            make.bottom.equalTo(contentView.snp.bottom).offset(-subLabelBottom).priority(.high)
        }
        
        flagLabel.snp.makeConstraints { make in
            make.width.equalTo(flagLabelWidth)
            make.height.equalTo(flagLabelHeight)
            make.left.equalToSuperview().offset(flagLabelLeft)
            make.top.equalTo(subLabel.snp.bottom).offset(flagLabelTop)
            make.bottom.equalToSuperview().offset(-flagLabelBottom)
        }
    } 
}
