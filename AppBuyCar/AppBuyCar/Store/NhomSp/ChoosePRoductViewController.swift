//
//  ChoosePRoductViewController.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 9/7/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit
protocol Category_Delegate {
    func chonNhom(idNhom:String, tenNhom:String)
}

class ChoosePRoductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var arr_Cate:[Category] = []
    @IBOutlet weak var myTable: UITableView!
    var delegate:Category_Delegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        // load cate
        
        loadCate()
    }
    func loadCate(){
        let url = URL(string: Config.ServerUrl + "/category")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: {   data, response,error in
            guard error == nil else {print("error");return}
            guard let data = data else {return}
            let jsonDecoder = JSONDecoder()
            do{
                let listCate = try jsonDecoder.decode(CategoryPostRoute.self, from: data)
                self.arr_Cate = listCate.CateList
            }catch{
                
            }
           
            DispatchQueue.main.async {
                self.myTable.reloadData()
            }
        })
        taskUserRegister.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_Cate.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cateCell = myTable.dequeueReusableCell(withIdentifier: "CatoryTableViewCell") as! CatoryTableViewCell
        cateCell.lbCate.text = arr_Cate[indexPath.row].Name
        
        let quequeImage = DispatchQueue(label: "quequeImage")
        quequeImage.async {
            if let urlImge = URL(string: Config.ServerUrl + "/upload/" + self.arr_Cate[indexPath.row].Image) {
            print(Config.ServerUrl + "/upload/" + self.arr_Cate[indexPath.row].Image)
            do{
                let dataImage = try? Data(contentsOf: urlImge)
                DispatchQueue.main.async {
                cateCell.imgCate.image = UIImage(data: dataImage!)
                }
            }catch{}
            }
        }
        
        
        return cateCell
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height/4
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.chonNhom(idNhom: arr_Cate[indexPath.row]._id, tenNhom: arr_Cate[indexPath.row].Name
        )
    }

}

