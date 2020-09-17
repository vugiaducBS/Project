//
//  ProductCellTableViewCell.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 9/15/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit

class ProductCellTableViewCell: UITableViewCell {
    @IBOutlet weak var ImageAvata: UIImageView!
    @IBOutlet weak var lbNhom: UILabel!
    @IBOutlet weak var lbTieuDe: UILabel!
    @IBOutlet weak var lbGia: UILabel!
    @IBOutlet weak var lbSDT: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
