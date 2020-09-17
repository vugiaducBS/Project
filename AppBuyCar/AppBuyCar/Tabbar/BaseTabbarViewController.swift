//
//  BaseTabbarViewController.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 8/6/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit

class BaseTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
         self.navigationItem.setHidesBackButton(true, animated: false)    }
    func setupTabbar(){
        let home = STORYBOARD_MAIN.instantiateViewController(identifier: "HomeViewController")
        home.tabBarItem = UITabBarItem(title: "Trang Chủ", image: UIImage.init(named: "1"), tag: 100)
        let navHome = BaseNavigationViewController(rootViewController: home)
        
      let store = STORYBOARD_MAIN.instantiateViewController(withIdentifier: "StoreViewController")
      store.tabBarItem = UITabBarItem(title: "Gian Hàng", image: #imageLiteral(resourceName: "gift"), tag: 200)
      let navStore = BaseNavigationViewController(rootViewController: store)
        
        let cart = STORYBOARD_MAIN.instantiateViewController(identifier: "CartViewController")
        cart.tabBarItem = UITabBarItem(title: "Giỏ Hàng", image: UIImage.init(named: "2"), tag: 300)
        let navCart = BaseNavigationViewController(rootViewController: cart)

        let profile = STORYBOARD_MAIN.instantiateViewController(identifier: "ProfileViewController")
        profile.tabBarItem = UITabBarItem(title: "Tài Khoản", image: UIImage.init(named: "3"), tag: 400)
        let navProfile = BaseNavigationViewController(rootViewController: profile)

        self.viewControllers = [navHome, navStore, navCart, navProfile]
        
    }

}
