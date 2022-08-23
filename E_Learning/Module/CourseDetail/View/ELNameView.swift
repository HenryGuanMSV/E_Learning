//
//  ELNameView.swift
//  E_Learning
//
//  Created by sin on 2022/8/23.
//

import UIKit

class ELNameView: ELBasicView {
    
    private let titleLabel = UILabel().then() {
        $0.backgroundColor = .clear
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(10.0)
        $0.textColor = UIColor.subTitleColor
        $0.text = "ZH" // 暂时写死
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCornerView()
        setupViews()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(titleLabel)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    private func setCornerView() {
        self.layer.cornerRadius = self.bounds.width * 0.5
    }
}
