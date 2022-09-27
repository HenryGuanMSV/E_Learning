//
//  ELCourseDetailViewController.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/16.
//

import UIKit
import Then
import SwiftyFitsize

class ELCourseDetailViewController: ELBasicViewController {

    let playViewHeight = 240.0∥

    let introViewWidth = 359.0≈
    let introViewTopOffset = 30.0∥

    let processViewHeight = 104.0∥
    let processViewTopOffset = 12.0∥

    let teacherViewViewHeight = 204.0∥ // 暂时写死
    let teacherViewViewTopOffset = 12.0∥

    let courseListViewHeight = 727.5∥ // 暂时写死
    let courseListViewTopOffset = 12.0∥

    let scrollViewBottomOffset = 25.0∥
    
    private var navView: ELCourseDetailNavView!
    
    private let scrollView = UIScrollView().then() {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private let playView = UIImageView(image: UIImage(named: "Frame 1")).then() {
        $0.addDefaultCorner()
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let introView = ELIntroView().then() {
        $0.backgroundColor = .whiteColor
        $0.addDefaultCorner()
        $0.addDefaultShadow()
    }
    
    private let processView = ELProgressView().then() {
        $0.backgroundColor = .whiteColor
        $0.addDefaultCorner()
        $0.addDefaultShadow()
    }

    private let infoView = ELCourseInfoView().then() {
        $0.backgroundColor = .whiteColor
        $0.addDefaultCorner()
        $0.addDefaultShadow()
    }
    
    private let courseListView = ELCourseContentListView().then() {
        $0.backgroundColor = .whiteColor
        $0.addDefaultCorner()
        $0.addDefaultShadow()
    }
    
    // ELContentView
    private let contentView = ELContentView().then() {
        $0.backgroundColor = .whiteColor
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layout()
        setupNoti()
    }
    
    /** 状态栏颜色 */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    /** 视图即将出现 */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navView.hide()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        courseListView.refreshData()
    }
    
    /** 视图即将移除 */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
        
    private func setupViews() {
        scrollView.delegate = self
        view.addSubview(scrollView)
        navView = ELCourseDetailNavView(frame: .zero, btnBackClosure: { [weak self] in
            self?.popViewControllerAnimated()
        })
        view.addSubview(navView)
        scrollView.addSubview(playView)
        scrollView.addSubview(introView)
        scrollView.addSubview(processView)
        scrollView.addSubview(infoView)
        scrollView.addSubview(courseListView)
        scrollView.addSubview(contentView)
    }
    
    private func layout() {
        navView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(NaviHeight)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        playView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(playViewHeight)
        }
        introView.snp.makeConstraints { make in
            make.width.equalTo(introViewWidth)
            make.top.equalTo(playView.snp.bottom).offset(-introViewTopOffset)
            make.centerX.equalTo(playView.snp.centerX)
        }
        processView.snp.makeConstraints { make in
            make.width.equalTo(introView.snp.width)
            make.top.equalTo(introView.snp.bottom).offset(processViewTopOffset)
            make.centerX.equalTo(playView.snp.centerX)
        }
        infoView.snp.makeConstraints { make in
            make.width.equalTo(introView.snp.width)
            make.top.equalTo(processView.snp.bottom).offset(teacherViewViewTopOffset)
            make.centerX.equalTo(playView.snp.centerX)
        }
        
        courseListView.snp.makeConstraints { make in
            make.width.equalTo(introView.snp.width)
            make.top.equalTo(infoView.snp.bottom).offset(courseListViewTopOffset)
            make.centerX.equalTo(playView.snp.centerX)            
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(introView.snp.width)
            make.top.equalTo(courseListView.snp.bottom)
            make.centerX.equalTo(playView.snp.centerX)
            make.bottom.lessThanOrEqualTo(scrollView.snp.bottom).offset(-scrollViewBottomOffset)
        }
    }
    
    private func setupNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func binding() {
        
    }
    
    @objc func becomeActive() {
        self.navView.setAlpha(offset: scrollView.contentOffset.y)
    }
}

extension ELCourseDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navView.setAlpha(offset: scrollView.contentOffset.y)
    }
}
