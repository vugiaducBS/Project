//
//  CatoryTableViewCell.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 9/7/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit

class CatoryTableViewCell: UITableViewCell {
    @IBOutlet weak var imgCate: UIImageView!
    @IBOutlet weak var lbCate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
