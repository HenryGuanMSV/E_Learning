//
//  ELBasicTableViewCell.swift
//  E_Learning
//
//  Created by sin on 2022/3/31.
//

import UIKit

/** 父类 TableviewCell */
class ELBasicTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        
        // 右侧样式
        self.accessoryType = UITableViewCell.AccessoryType.none
        // 点击无效果
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
