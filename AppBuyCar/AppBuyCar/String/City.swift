//
//  City.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 9/9/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import Foundation
struct CityPostRoute:Decodable {
    var kq:Int
    var list:[City]
}
struct City:Decodable {
    var _id: String
    var Name:String
    init(id:String, name:String) {
        self._id = id
        self.Name = name
}
}
