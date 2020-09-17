//
//  HomeViewController.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 8/6/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var myTable: UITableView!
    var arrProduct:[Product] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Trang Chủ"
        myTable.delegate = self
        myTable.dataSource = self
        loadCate()
    }
  func loadCate(){
           let url = URL(string: Config.ServerUrl + "/post")
           var request = URLRequest(url: url!)
           request.httpMethod = "POST"
           let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: {   data, response,error in
               guard error == nil else {print("error");return}
               guard let data = data else {return}
               let jsonDecoder = JSONDecoder()
               do{
                let listCate = try jsonDecoder.decode(ProductPostRoute.self, from: data)
                self.arrProduct = listCate.CateProduct
               }catch{
                   
               }
              
               DispatchQueue.main.async {
                   self.myTable.reloadData()
               }
           })
           taskUserRegister.resume()
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProduct.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = myTable.dequeueReusableCell(withIdentifier: "ProductCellTableViewCell") as! ProductCellTableViewCell
        cell.lbNhom.text = arrProduct[indexPath.row].Nhom
        cell.lbTieuDe.text = arrProduct[indexPath.row].TieuDe
        cell.lbGia.text = arrProduct[indexPath.row].Gia
        cell.lbSDT.text = arrProduct[indexPath.row].DienThoai
               let quequeImage = DispatchQueue(label: "quequeImage")
               quequeImage.async {
                   if let urlImge = URL(string: Config.ServerUrl + "/upload/" + self.arrProduct[indexPath.row].Image) {
                   print(Config.ServerUrl + "/upload/" + self.arrProduct[indexPath.row].Image)
                   do{
                       let dataImage = try? Data(contentsOf: urlImge)
                       DispatchQueue.main.async {
                       cell.ImageAvata.image = UIImage(data: dataImage!)
                       }
                   }catch{}
                   }
               }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height/6
}
}
