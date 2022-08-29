//
//  ELHomePageViewController.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/14.
//

import UIKit

class ELHomePageViewController: ELBasicViewController, BannerViewDelegate {

    var banner: AKBannerView!
    let bannerHeight = self.view.width/2
    
    // MARK: 销毁
    deinit {
        print("销毁ELHomePageViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        lazy var moreBtn: UIButton = {
            let button = UIButton(type: .contactAdd)
            button.center = view.center
            button.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
            return button
        }()
        view.addSubview(moreBtn)
        
        layout()
        binding()
        creatBanner()
    }
    
    /** 视图即将出现 */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    /** 视图即将移除 */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
        
    private func layout() {
        
    }
    
    func creatBanner()  {
        
        let items: [AKBannerItem] = [
            AKBannerItem(image: "banner_1".localizedImage),
            AKBannerItem(image: "banner_2".localizedImage),
            AKBannerItem(image: "banner_3".localizedImage)
        ]
        banner = .init(frame: CGRect.init(x: 0, y: -5, width: self.view.width, height: bannerHeight))
        banner.setup(
            type: BannerViewScrollType.fromStart,
            timeForOneItem: 2,
            bannerItems: items,
            delegate: self
        )
        
        let maskPath = UIBezierPath(roundedRect: banner.bounds, byRoundingCorners: [UIRectCorner.bottomRight, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = banner.bounds
        maskLayer.path = maskPath.cgPath
        banner.layer.mask = maskLayer
        
        self.view.addSubview(banner)
    }
    
    func creatTopLearning()  {
        
        
        
        
    }
    private func binding() {
        
    }
    
    @objc func doneButtonClick() {
        Navigator.nav2TestVC()
    }
    
}
