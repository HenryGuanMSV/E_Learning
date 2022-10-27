//
//  ELUserIntroViewController.swift
//  E_Learning
//
//  Created by sin kwan on 2022/10/27.
//

import UIKit

class ELUserIntroViewController: ELBasicViewController {

    // MARK: 销毁
    deinit {
        print("销毁ELMyViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple        
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
        
    }
    
    private func layout() {

    }
    
    private func binding() {
        
    }
    
}
