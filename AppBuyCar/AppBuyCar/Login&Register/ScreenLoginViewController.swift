//
//  ScreenLoginViewController.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 8/2/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit

class ScreenLoginViewController: UIViewController {
    @IBOutlet weak var btonLogin: UIButton!
    @IBOutlet weak var btonRegister: UIButton!
    @IBOutlet weak var lbUsername: UITextField!
    @IBOutlet weak var lbPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btonLogin.layer.cornerRadius = 20
        self.btonLogin.clipsToBounds = true
        self.btonRegister.layer.cornerRadius = 20
        self.btonRegister.clipsToBounds = true
        self.navigationItem.setHidesBackButton(true, animated: false)        
    }
    @IBAction func btRegister(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let REGISTER = storyboard.instantiateViewController(identifier: "RegisterViewController")
        self.navigationController?.pushViewController(REGISTER, animated: true)
    }
    
    @IBAction func btLogin(_ sender: Any) {
        let url = URL(string: Config.ServerUrl + "/login")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        var sData = "Username=" + self.lbUsername.text!
        sData += "&Password=" + self.lbPassword.text!
        let postData = sData.data(using: .utf8)
        request.httpBody = postData
        let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: {   data, response,error in
            guard error == nil else {print("error"); return}
            guard let data = data else {return}
            do{
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {return}
                if ( json["kq"] as! Int == 1){
                    // Succesful
                    let defaults = UserDefaults.standard
                    defaults.set(json["Token"], forKey: "UserToken");
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Thong Bao", message: "Login Succesfully", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action:UIAlertAction) in
                            self.navigationController?.popViewController(animated: false)      }))
                        self.present(alertView, animated: true,completion: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Thong Bao", message: json["errMsg"] as? String, preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alertView, animated: true, completion: nil)
                        }
                }
            }catch let error { print(error.localizedDescription)}
        })
        taskUserRegister.resume()

    }
    
    
    
    
    
    
}
