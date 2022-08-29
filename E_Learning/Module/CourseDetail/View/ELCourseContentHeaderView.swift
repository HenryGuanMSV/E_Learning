//
//  ELCourseContentHeaderView.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/29.
//

import UIKit
import SwiftyFitsize

class ELCourseContentHeaderView: ELBasicView {

    let firstLabelTop = 16.0∥
    let firstLabelLeft = 12.0≈
    let firstLabelBottom = 12.5∥
    
    let middleLabelLeft = 33.5≈
    let rightLabelLeft = 48.5≈
    
    let leftClickClosure: () -> Void
    let middleClickClosure: () -> Void
    let rightClickClosure: () -> Void
    
    var currentIndex = 0 // 记录选中状态
    
    private let firstLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.titleSelectedColor
        $0.text = COURSE_CONTENT_LIST_TITLE_1
        $0.isUserInteractionEnabled = true
    }
    
    private let middleLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.titleColor
        $0.text = COURSE_CONTENT_LIST_TITLE_2
        $0.isUserInteractionEnabled = true
    }
    
    private let rightLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.titleColor
        $0.text = COURSE_CONTENT_LIST_TITLE_3
        $0.isUserInteractionEnabled = true
    }
    
    
    required init(frame: CGRect, leftClosure: @escaping () -> Void, middleClosure: @escaping () -> Void, rightClosure: @escaping () -> Void) {        
        self.leftClickClosure = leftClosure
        self.middleClickClosure = middleClosure
        self.rightClickClosure = rightClosure
        super.init(frame: frame)
        setupViews()
        layout()
        addEvent()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.backgroundColor = .whiteColor
        self.addDefaultCorner()
        
        addSubview(firstLabel)
        addSubview(middleLabel)
        addSubview(rightLabel)
    }
    
    private func layout() {
        firstLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(firstLabelTop)
            make.left.equalToSuperview().offset(firstLabelLeft)
            make.bottom.equalToSuperview().offset(-firstLabelBottom)
        }
        
        middleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(firstLabel.snp.centerY)
            make.left.equalTo(firstLabel.snp.right).offset(middleLabelLeft)
        }
        
        rightLabel.snp.makeConstraints { make in
            make.centerY.equalTo(firstLabel.snp.centerY)
            make.left.equalTo(middleLabel.snp.right).offset(rightLabelLeft)
        }
    }
    
    private func addEvent() {
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(tapOne))
        firstLabel.addGestureRecognizer(tapOne)
        
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(tapTwo))
        middleLabel.addGestureRecognizer(tapTwo)
        
        let tapThree = UITapGestureRecognizer(target: self, action: #selector(tapThree))
        rightLabel.addGestureRecognizer(tapThree)
    }
        
    @objc func tapOne() {
        guard currentIndex != 0 else {
            return
        }
        
        firstLabel.textColor = UIColor.titleSelectedColor
        middleLabel.textColor = UIColor.titleColor
        rightLabel.textColor = UIColor.titleColor
        currentIndex = 0
        leftClickClosure()
    }
    
    @objc func tapTwo() {
        guard currentIndex != 1 else {
            return
        }
        
        firstLabel.textColor = UIColor.titleColor
        middleLabel.textColor = UIColor.titleSelectedColor
        rightLabel.textColor = UIColor.titleColor
        currentIndex = 1
        middleClickClosure()
    }
    
    @objc func tapThree() {
        guard currentIndex != 2 else {
            return
        }
        
        firstLabel.textColor = UIColor.titleColor
        middleLabel.textColor = UIColor.titleColor
        rightLabel.textColor = UIColor.titleSelectedColor
        currentIndex = 2
        rightClickClosure()
    }
}
