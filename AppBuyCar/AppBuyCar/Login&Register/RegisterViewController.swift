//
//  RegisterViewController.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 8/5/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var lbName: UITextField!
    @IBOutlet weak var lbUsername: UITextField!
    @IBOutlet weak var lbPassword: UITextField!
    @IBOutlet weak var lbEmail: UITextField!
    @IBOutlet weak var lbPhone: UITextField!
    @IBOutlet weak var lbAdress: UITextField!
    @IBOutlet weak var imageAvatar: UIImageView!
    
    @IBOutlet weak var mySpinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.register.layer.cornerRadius = 20
        self.register.clipsToBounds = true
        self.imageAvatar.layer.cornerRadius = imageAvatar.frame.size.width/2
        self.imageAvatar.layer.masksToBounds = true
        self.mySpinner.isHidden = true
    }
    @IBAction func RegisterToServer(_ sender: Any) {
        //register(url: "http://192.168.1.4:3000/register")
        self.mySpinner.isHidden = false
        self.mySpinner.startAnimating()
        var url = URL(string: Config.ServerUrl + "/uploadFile")
        let boundary = UUID().uuidString
        let session = URLSession.shared
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"hinhdaidien\"; filename=\"avatar.png\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append((imageAvatar.image?.pngData())!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any]{
                    if(json["kq"] as! Int == 1){
                        let urlFile = json["urlFile"] as? [String:Any]
                        print(urlFile!["filename"])
                        // setp2: send user register  nên gửi = json
                        //let queueSendUserInformation = DispatchQueue(label: "SendUserInformation")
                        DispatchQueue.main.async {
                            // gui user gom url , session
                            url = URL(string: Config.ServerUrl + "/register")
                            var request = URLRequest(url: url!)
                            request.httpMethod = "POST"
                            let fileName = urlFile!["filename"] as! String
                            var sData = "Username=" + self.lbUsername.text!
                            sData += "&Password=" + self.lbPassword.text!
                            sData += "&Name=" + self.lbName.text!
                            sData += "&Image=" + fileName
                            sData += "&Email=" +  self.lbEmail.text!
                            sData += "&Address=" + self.lbAdress.text!
                            sData += "&PhoneNumber" + self.lbPhone.text!
                            let postData = sData.data(using: .utf8)
                            request.httpBody = postData
                            let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: {   data, response,error in
                                guard error == nil else {return}
                                guard let data = data else {return}
                                do{
                                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {return}
                                    DispatchQueue.main.async {
                                        self.mySpinner.isHidden = true
                                    }
                                    if ( json["kq"] as! Int == 1){
                                        // Succesful
                                        DispatchQueue.main.async {
                                            let alertView = UIAlertController(title: "Thong Bao", message: "Register Successfully", preferredStyle: .alert)
                                            alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                                            self.present(alertView, animated: true, completion: nil)

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
                    }else{
                        print("Upload failed!")
                    }
                }
            }
            
        }).resume()
        
    }
    
    @IBAction func ChoseImageGallery(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            imageAvatar.image = image
        }else {
            print("Errer Image")
        }
        self.dismiss(animated: true, completion: nil)
    }

}
