//
//  Category.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 9/7/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import Foundation
struct CategoryPostRoute:Decodable {
    var kq:Int
    var CateList:[Category]
}
struct Category:Decodable {
    var _id: String
    var Name:String
    var Image:String
    
    init(id:String, name:String, image:String) {
        self._id = id
        self.Name = name
        self.Image = image
    }
    }
