//
//  ELHomePageViewController.swift
//  E_Learning
//
//  Created by sin kwan on 2022/8/14.
//

import UIKit

class ELHomePageViewController: ELBasicViewController {

    // MARK: 销毁
    deinit {
        print("销毁ELHomePageViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        layout()
        binding()
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
    
    private func binding() {
        
    }
}