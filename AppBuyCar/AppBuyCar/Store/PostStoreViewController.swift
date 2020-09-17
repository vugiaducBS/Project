//
//  PostStoreViewController.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 9/5/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit

class PostStoreViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var text_tieude: UITextField!
    @IBOutlet weak var ImagePost: UIImageView!
    @IBOutlet weak var txt_Gia: UITextField!
    @IBOutlet weak var txt_DienThoai: UITextField!
    @IBOutlet weak var txt_DiaChi: UITextField!
    @IBOutlet weak var lbNhom: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    
    var idNhom_Update:String?
    var idCity_Update:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func Tap_Image(_ sender: Any) {
        // Hien thi khung chon hinh
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            ImagePost.image = image
        }else {
            print("Errer Image")
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func ChooseProduct(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let Chooseproduct = sb.instantiateViewController(withIdentifier: "ChoosePRoductViewController") as! ChoosePRoductViewController
        Chooseproduct.delegate = self
        self.navigationController?.pushViewController(Chooseproduct, animated: true)
    }
    @IBAction func ChooseCity(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let chooseCity = sb.instantiateViewController(withIdentifier: "CityViewController") as! CityViewController
        chooseCity.delegate = self
        self.navigationController?.pushViewController(chooseCity, animated: true)
        
    }
    
    @IBAction func BanSp(_ sender: Any) {
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
        data.append((ImagePost.image?.pngData())!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any]{
                    if(json["kq"] as! Int == 1){
                        let urlFile = json["urlFile"] as? [String:Any]
                        print(urlFile!["filename"])
                        // setp2: send user register  nên gửi = json
                            DispatchQueue.main.async {
                            // gui user gom url , session
                            url = URL(string: Config.ServerUrl + "/post/add")
                            var request = URLRequest(url: url!)
                            request.httpMethod = "POST"
                            let fileName = urlFile!["filename"] as! String
                            
                            var sData = "TieuDe=" + self.text_tieude.text!
                            sData += "&Gia=" + self.txt_Gia.text!
                            sData += "&DienThoai=" + self.txt_DienThoai.text!
                            sData += "&Image=" + fileName
                            sData += "&Nhom=" + self.idNhom_Update!
                            sData += "&NoiBan=" + self.idCity_Update!
                            sData += "&PhoneNumber" + self.txt_DienThoai.text!
                            let postData = sData.data(using: .utf8)
                            request.httpBody = postData
                            let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: {   data, response,error in
                                guard error == nil else {return}
                                guard let data = data else {return}
                                do{
                                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {return}
                                    if ( json["kq"] as! Int == 1){
                                        // Succesful
                                        DispatchQueue.main.async {
                                            let alertView = UIAlertController(title: "Thong Bao", message: "Post Thanh Cong", preferredStyle: .alert)
                                            alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                                            self.present(alertView, animated: true, completion: nil)

                                        }

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
}
extension PostStoreViewController:Category_Delegate {
    func chonNhom(idNhom:String, tenNhom:String){
        self.navigationController?.popViewController(animated: true)
        lbNhom.text = tenNhom
        idNhom_Update = idNhom
    }
}
extension PostStoreViewController:City_Delegate{
    func chon_City(_id: String, Name: String) {
        self.navigationController?.popViewController(animated: true)
        lbCity.text = Name
        idCity_Update = _id
    }
}
