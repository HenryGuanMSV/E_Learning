//
//  ELContentEditHeaderView.swift
//  E_Learning
//
//  Created by sin kwan on 2022/9/28.
//

import UIKit
import SwiftyFitsize
import RSKPlaceholderTextView

class ELContentEditHeaderView: UITableViewHeaderFooterView {

    let titleLabelLeft = 12.0≈
    let textViewTop = 9∥
    let textViewHeight = 94∥
    let textViewBottom = 12∥
    
    private let contentBaseView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let titleLabel = UILabel().then() {
        $0.numberOfLines = 0
        $0.font = UIFont.pingFangRegular(12.0)
        $0.textColor = UIColor.titleColor
        $0.text = Discuss_TIPS
    }

    private let starView = StarEvaluateView(sumCount: 5, starSpace: 12.0≈, norImg: UIImage(named: "Bars／icon／starSpace"), selImg: UIImage(named: "yellowStar")).then {
        $0.hasShowHalfStar = false
        $0.frame = CGRectMake(224≈, 2∥, 130≈, 12∥)
    }
    
    private let textView = RSKPlaceholderTextView(frame: CGRectMake(12≈, 24∥, 335≈, 94∥)).then {
        $0.placeholder = "Comments"
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 8≈
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        print(self.frame.height)
    }
    
    private func setupViews() {
        contentView.addSubview(contentBaseView)
        self.width = SCREEN_WIDTH
        contentBaseView.width = SCREEN_WIDTH
        
        contentBaseView.addSubview(titleLabel)
        contentBaseView.addSubview(starView)
        contentBaseView.addSubview(textView)
    }
    
    private func layout() {
        contentBaseView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentBaseView.snp.top)
            make.left.equalToSuperview().offset(titleLabelLeft)
        }
        
        textView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(titleLabelLeft)
            make.width.equalTo(335≈)
            make.top.equalTo(titleLabel.snp.bottom).offset(textViewTop)
            make.height.equalTo(textViewHeight)
            make.bottom.equalToSuperview().offset(-textViewBottom)
        }
    }
}
