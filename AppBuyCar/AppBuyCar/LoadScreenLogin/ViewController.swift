//
//  ViewController.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 8/2/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    var countdown = 3
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.layer.cornerRadius = image.frame.size.width / 2
        self.image.layer.masksToBounds = true
        image.frame.origin.x = 0 - image.frame.size.width
        UIView.animate(withDuration: 2, animations: {
            self.image.frame.origin = CGPoint(
                x: self.view.frame.size.width/2 - self.image.frame.size.width/2
                , y: self.view.frame.size.height/2 - self.image.frame.size.height/2)
        }, completion: nil)
        LoadingScreen()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.NSTimer), userInfo: nil, repeats: true)
        
    }
    func LoadingScreen(){
        view.backgroundColor = UIColor.black
        UIView.animate(withDuration: 3, animations: {
            self.image.alpha = 0
            self.view.backgroundColor = UIColor.white
        })
}
    @objc func NSTimer(){
        countdown = countdown - 1
        if countdown == 1{
            timer.invalidate()
//            let SCENE_DELEGATE = self.view.window?.windowScene?.delegate as! SceneDelegate
//            SCENE_DELEGATE.login(isLoged: true)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = sb.instantiateViewController(identifier: "BaseTabbarViewController") as! BaseTabbarViewController
        self.navigationController?.pushViewController(tabbar, animated: true)


        }
    }
    
    }

