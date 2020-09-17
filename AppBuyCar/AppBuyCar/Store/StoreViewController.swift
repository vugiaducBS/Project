//
//  StoreViewController.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 9/5/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Gian Hàng"
        // Do any additional setup after loading the view.
    }
    @IBAction func btPostStore(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let Store = sb.instantiateViewController(withIdentifier: "PostStoreViewController")
        self.navigationController?.pushViewController(Store, animated: true)
    }
 

}
