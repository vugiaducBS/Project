//
//  CityViewController.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 9/9/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import UIKit
protocol City_Delegate {
    func chon_City(_id:String, Name:String)
}
class CityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTable: UITableView!
    var arrCity:[City] = []
    var delegate:City_Delegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self
        loadCity()
    }
    func loadCity(){
        let url = URL(string: Config.ServerUrl + "/city")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: {   data, response,error in
                guard error == nil else {print("error");return}
                guard let data = data else {return}
                let jsonDecoder = JSONDecoder()
                do{
                    let listCity = try jsonDecoder.decode(CityPostRoute.self, from: data)
                    self.arrCity = listCity.list
                    
                }catch{
                    
                }
               
                DispatchQueue.main.async {
                    self.myTable.reloadData()
                }
            })
            taskUserRegister.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCity.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityCell = myTable.dequeueReusableCell(withIdentifier: "CityTableViewCell") as! CityTableViewCell
        cityCell.lbCity.text = arrCity[indexPath.row].Name
        return cityCell
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.chon_City(_id: arrCity[indexPath.row]._id, Name: arrCity[indexPath.row].Name)
    }

}
