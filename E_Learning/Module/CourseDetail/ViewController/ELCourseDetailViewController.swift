//
//  ELCourseDetailViewController.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/16.
//

import UIKit
import Then


class ELCourseDetailViewController: ELBasicViewController {

    let playViewHeight = 240.0

    let introViewWidth = 359.0
    let introViewTopOffset = 30.0

    let processViewHeight = 104.0
    let processViewTopOffset = 12.0

    let teacherViewViewHeight = 204.0 // 暂时写死
    let teacherViewViewTopOffset = 12.0

    let courseListViewHeight = 727.5 // 暂时写死
    let courseListViewTopOffset = 12.0

    let scrollViewBottomOffset = 12.0 + TABBAR_HEIGHT_X

    
    private let scrollView = UIScrollView().then() {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private let playView = ELBasicView().then() {
        $0.backgroundColor = .black
        $0.addDefaultCorner()
    }
    
    private let introView = ELIntroView().then() {
        $0.backgroundColor = .whiteColor
        $0.addDefaultCorner()
        $0.addDefaultShadow()
    }
    
    private let processView = ELBasicView().then() {
        $0.backgroundColor = .whiteColor
        $0.addDefaultCorner()
        $0.addDefaultShadow()
    }

    private let teacherView = ELBasicView().then() {
        $0.backgroundColor = .whiteColor
        $0.addDefaultCorner()
        $0.addDefaultShadow()
    }
    
    private let courseListView = ELBasicView().then() {
        $0.backgroundColor = .whiteColor
        $0.addDefaultCorner()
        $0.addDefaultShadow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layout()
    }
    
    /** 状态栏颜色 */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    /** 视图即将出现 */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    /** 视图即将移除 */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
        
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(playView)
        scrollView.addSubview(introView)
        scrollView.addSubview(processView)
        scrollView.addSubview(teacherView)
        scrollView.addSubview(courseListView)
    }
    
    private func layout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        playView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(scaleNum(playViewHeight))
        }
        introView.snp.makeConstraints { make in
            make.width.equalTo(scaleNum(introViewWidth))
            make.top.equalTo(playView.snp.bottom).offset(-scaleNum(introViewTopOffset))
            make.centerX.equalTo(playView.snp.centerX)
        }
        processView.snp.makeConstraints { make in
            make.width.equalTo(introView.snp.width)
            make.height.equalTo(scaleNum(processViewHeight))
            make.top.equalTo(introView.snp.bottom).offset(scaleNum(processViewTopOffset))
            make.centerX.equalTo(playView.snp.centerX)
        }
        teacherView.snp.makeConstraints { make in
            make.width.equalTo(introView.snp.width)
            make.height.equalTo(scaleNum(teacherViewViewHeight))
            make.top.equalTo(processView.snp.bottom).offset(scaleNum(teacherViewViewTopOffset))
            make.centerX.equalTo(playView.snp.centerX)
        }
        courseListView.snp.makeConstraints { make in
            make.width.equalTo(introView.snp.width)
            make.height.equalTo(scaleNum(courseListViewHeight))
            make.top.equalTo(teacherView.snp.bottom).offset(scaleNum(courseListViewTopOffset))
            make.centerX.equalTo(playView.snp.centerX)
            make.bottom.lessThanOrEqualTo(scrollView.snp.bottom).offset(-scaleNum(scrollViewBottomOffset))
        }
    }
    
    private func binding() {
        
    }

}
