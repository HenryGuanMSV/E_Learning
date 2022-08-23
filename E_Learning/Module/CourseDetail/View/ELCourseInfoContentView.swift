//
//  ELCourseInfoContentView.swift
//  E_Learning
//
//  Created by sin on 2022/8/23.
//

import UIKit
import SwiftyFitsize

class ELCourseInfoContentView: ELBasicView {

    let contentViewHeight = 83.0∥
    
    var isOpen: Bool = false
    
    private let titleView = ELCourseInfoTitleView().then() {
        $0.isUserInteractionEnabled = true
    }

    private let contentView = UIView().then() {
        $0.backgroundColor = .green
        $0.addDefaultCorner()
    }

    override init(frame: CGRect) {
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
        addSubview(titleView)
        addSubview(contentView)
    }
    
    private func layout() {
        titleView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
    }
    
    private func addEvent() {
       let reco = UITapGestureRecognizer(target: self, action: #selector(titleViewTap))
       titleView.addGestureRecognizer(reco)
    }
    
    @objc func titleViewTap() {
        if !isOpen {
            showLayout()
        } else {
            hideLayout()
        }
        isOpen = !isOpen
    }
    
    // 展开样式
    func showLayout() {
        contentView.snp.updateConstraints { make in
            make.height.equalTo(contentViewHeight) // 暂时写死
        }
    }
    
    // 隐藏样式
    func hideLayout() {
        contentView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
    }
}
