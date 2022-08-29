//
//  ELCourseDetailNavView.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/29.
//

import UIKit
import SwiftyFitsize

class ELCourseDetailNavView: ELBasicView {

    let backBtnSize = 16.0≈
    let backBtnLeft = 16.0≈
    let backBtnBottom = 17.0∥
    
    let searchBtnSize = 16.0≈
    let searchBtnRight = 16.0≈
    
    let backBtnClosure: () -> Void
    
    private let bgView = UIView().then() {
        $0.backgroundColor = .navBgColor
    }
    
    private let backBtn = UIButton(type: .custom).then() {
        $0.backgroundColor = .clear
        $0.setBackgroundImage(UIImage(named: "icon／arrowLeft32"), for: .normal)
    }
    
    private let searchBtn = UIButton(type: .custom).then() {
        $0.backgroundColor = .clear
        $0.setBackgroundImage(UIImage(named: "icon／search32"), for: .normal)
    }
        
    required init(frame: CGRect, btnBackClosure: @escaping () -> Void) {
        self.backBtnClosure = btnBackClosure
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
        self.backgroundColor = .clear
        addSubview(bgView)
        addSubview(backBtn)
        addSubview(searchBtn)
    }
    
    private func layout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(backBtnSize)
            make.left.equalToSuperview().offset(backBtnLeft)
            make.bottom.equalToSuperview().offset(-backBtnBottom)
        }
        
        searchBtn.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn.snp.centerY)
            make.size.equalTo(searchBtnSize)
            make.right.equalToSuperview().offset(-searchBtnRight)
        }
    }

    private func addEvent() {
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
    }
    
    @objc func backBtnClick() {
        self.backBtnClosure()
    }
    
    func show() {
        self.bgView.alpha = 1.0
    }
    
    func hide() {
        self.bgView.alpha = 0.0
    }
    
    func setAlpha(offset: Double) {
        let alpha = 1 - (NaviHeight - offset) / NaviHeight
        self.bgView.alpha = alpha
    }
}
