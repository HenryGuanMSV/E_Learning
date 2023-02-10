//
//  MenuListNameCell.swift
//  E_Learning
//
//  Created by Aiken on 2023/2/6.
//

import UIKit

class MenuListNameCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func CreatUI(titleText:String) {
        titleLab.text = titleText
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
