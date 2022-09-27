//
//  ELContentView.swift
//  E_Learning
//
//  Created by sin kwan on 2022/9/27.
//

import UIKit
import SwiftyFitsize

class ELContentView: ELBasicTableViewCell {

    let titleLabelLeft = 12.0≈
    let timeLabelTop = 9.0∥
    let timeLabelBottom = 24.0∥
    
    let firstItemTop = 24.0∥
    let itemMargin = 8.0∥
    let itemRight = 12.0≈
    let itemBottom = 48.0∥
    
    
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

    private var itemArray: [ELContentViewItem]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        itemArray = []
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        initData()
        setupViews()
        layout()
        layoutItems()

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initData() {
        let oneItem = ELContentViewItem()
        oneItem.updateTitle(title: "Vue 介绍")
        oneItem.updateStyle(style: .arrowStyle)
        itemArray.append(oneItem)
        
        let twoItem = ELContentViewItem()
        twoItem.updateTitle(title: "Vue 实例")
        twoItem.updateStyle(style: .arrowStyle)
        itemArray.append(twoItem)

        let threeItem = ELContentViewItem()
        threeItem.updateTitle(title: "Class 与 Style 绑定")
        threeItem.updateStyle(style: .arrowStyle)
        itemArray.append(threeItem)

        let fourItem = ELContentViewItem()
        fourItem.updateTitle(title: "Quizz")
        fourItem.updateStyle(style: .timingStlye)
        itemArray.append(fourItem)
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(titleLabelLeft)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(timeLabelTop)
            if (itemArray.count == 0) {
                make.bottom.equalToSuperview().offset(-timeLabelBottom)
            }
        }
    }

    private func layoutItems() {
        for (index, element) in itemArray.enumerated() {
            contentView.addSubview(element)
            if index == 0 {
                element.snp.makeConstraints { make in
                    make.left.equalTo(timeLabel.snp.left)
                    make.right.equalToSuperview().offset(-itemRight)
                    make.top.equalTo(timeLabel.snp.bottom).offset(firstItemTop)
                }
            } else {
                let lastElement = itemArray[index - 1]
                element.snp.makeConstraints { make in
                    make.left.equalTo(timeLabel.snp.left)
                    make.right.equalToSuperview().offset(-itemRight)
                    make.top.equalTo(lastElement.snp.bottom).offset(itemMargin)
                    if index == itemArray.count - 1 {
                        make.bottom.equalToSuperview().offset(-itemBottom)
                    }
                }
            }
        }
    }
}
