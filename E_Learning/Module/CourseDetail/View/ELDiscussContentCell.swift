//
//  ELDiscussContentCell.swift
//  E_Learning
//
//  Created by sin kwan on 2022/9/28.
//

import UIKit
import SwiftyFitsize

class ELDiscussContentCell: ELBasicTableViewCell {

    let nameViewLeft = 12.0≈
    let nameViewWidth = 24.0≈
    let nameViewHeight = 24.0≈
    let nameLabelTop = 4.0∥
    let nameLabelLeft = 12.0≈
    let contentLabelTop = 7.5∥
    let contentLabelRight = 13.0≈
    let dateLabelTop = 4∥
    let dateLabelBottom = 16∥
    
    private let nameView = ELNameView(frame: CGRect(x: 0, y: 0, width: 24.0≈, height: 24.0≈)).then() {
        $0.backgroundColor = .nameViewBGColor
    }

    private let nameLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(10.0)
        $0.textColor = UIColor.subTitleColor
        $0.text = "ZhiPeng Ni" // 暂时写死
    }

    private let contentLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(10.0)
        $0.textColor = UIColor.subTitleColor
        $0.text = "模板语法、计算属性和侦听器、 Class 与 Style 绑定、条件渲染、列表渲染、事件处理、表单输入绑定、组件基础、样式渲染的" // 暂时写死
    }

    private let dateLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(8.0)
        $0.textColor = UIColor.subTitleColor
        $0.text = "03/12/1970" // 暂时写死
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
        contentView.addSubview(nameView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func layout() {
        nameView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(nameViewLeft)
            make.width.equalTo(nameViewWidth)
            make.height.equalTo(nameViewHeight)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(nameLabelTop)
            make.left.equalTo(nameView.snp.right).offset(nameLabelLeft)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.right.lessThanOrEqualTo(contentView.snp.right).offset(-contentLabelRight)
            make.top.equalTo(nameLabel.snp.bottom).offset(contentLabelTop)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(contentLabel)
            make.top.equalTo(contentLabel.snp.bottom).offset(dateLabelTop)
            make.bottom.equalTo(contentView.snp.bottom).offset(-dateLabelBottom)
        }
    }
}
