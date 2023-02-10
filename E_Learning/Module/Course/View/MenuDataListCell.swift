//
//  MenuDataListCell.swift
//  E_Learning
//
//  Created by Aiken on 2023/2/6.
//

import UIKit

class MenuDataListCell: UITableViewCell {

    
    @IBOutlet weak var iconImg1: UIImageView!
    @IBOutlet weak var titleLab1: UILabel!
    @IBOutlet weak var iconImg2: UIImageView!
    @IBOutlet weak var titleLab2: UILabel!
    @IBOutlet weak var iconImg3: UIImageView!
    @IBOutlet weak var titleLab3: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func CreatUI(infoData:[String]) {
        for i in 0...(infoData.count ) - 1 {
            var info = infoData[i]
            if i == 0 {
                iconImg1.image = UIImage.init(named: info )
                titleLab1.text = info
            }else if i == 1 {
                iconImg2.image = UIImage.init(named: info )
                titleLab2.text = info
            }else if i == 2 {
                iconImg3.image = UIImage.init(named: info )
                titleLab3.text = info
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
