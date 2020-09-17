//
//  ProfileViewController.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 8/6/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    
    let defaults = UserDefaults.standard
    
        override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Tài Khoản"
        self.navigationController?.setToolbarHidden(true, animated: false)
            image.layer.cornerRadius = image.frame.size.width/2
        checkLogin()
    }
    @IBAction func Logout(_ sender: Any) {
        if let UserToken = defaults.string(forKey: "UserToken"){
            let url = URL(string: Config.ServerUrl + "/logout")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            var sData = "Token=" + UserToken
            let postData = sData.data(using: .utf8)
            request.httpBody = postData
            let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: {   data, response,error in
                guard error == nil else {print("error"); return}
                guard let data = data else {return}
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {return}
                    if ( json["kq"] as! Int == 1){
                        self.defaults.removeObject(forKey: "UserToken")
                        DispatchQueue.main.async {
                            let sb = UIStoryboard(name: "Main", bundle: nil)
                            let loginback = sb.instantiateViewController(identifier: "ScreenLoginViewController") as! ScreenLoginViewController
                            self.navigationController?.pushViewController(loginback, animated: false)
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

        }else{
            
        }
    }
    func checkLogin(){

        if let UserToken = defaults.string(forKey: "UserToken"){
            let url = URL(string: Config.ServerUrl + "/verifyToken")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            var sData = "Token=" + UserToken
            let postData = sData.data(using: .utf8)
            request.httpBody = postData
            let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: {   data, response,error in
                guard error == nil else {return}
                guard let data = data else {return}
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {return}
                    if ( json["kq"] as! Int == 1){
                        // Succesful
                      print("okay")
                        let user = json["User"] as? [String:Any]
                        let imgString = user!["Image"] as? String
                        let urlHinh = Config.ServerUrl + "/upload/" + imgString!
                        DispatchQueue.main.async {
                            do{
                            let imgData = try! Data(contentsOf: URL(string: urlHinh)!)
                                self.image.image = UIImage(data: imgData)
                            }catch{
                                print("error image url")
                            }
                            self.username.text = user!["Name"] as? String
                            self.email.text = user!["Address"] as? String
                        }
                    }else{
                        DispatchQueue.main.async {
                            let sb = UIStoryboard(name: "Main", bundle: nil)
                            let loginback = sb.instantiateViewController(identifier: "ScreenLoginViewController") as! ScreenLoginViewController
                            self.navigationController?.pushViewController(loginback, animated: false)
                        }

                    }
                }catch let error { print(error.localizedDescription)}
            })
            taskUserRegister.resume()
        }else{
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loginback = sb.instantiateViewController(identifier: "ScreenLoginViewController") as! ScreenLoginViewController
        self.navigationController?.pushViewController(loginback, animated: false)
        }

    }
    
    
    
    
    
}

