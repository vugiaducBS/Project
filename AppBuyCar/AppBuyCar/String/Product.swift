//
//  Product.swift
//  AppBuyCar
//
//  Created by Vũ Đức on 9/15/20.
//  Copyright © 2020 VuGiaDuc. All rights reserved.
//

import Foundation
struct ProductPostRoute:Decodable {
    var kq:Int
    var CateProduct:[Product]
}
struct Product:Decodable {
    var _id: String
    var TieuDe: String
    var Gia: String
    var DienThoai: String
    var Image: String
    var Nhom: String
    var NoiBan: String
    var NgayDang: String
    init(id:String, tieude:String, gia:String, dienthoai:String, image:String, nhom:String, noiban: String, ngaydang: String) {
        self._id = id
        self.TieuDe = tieude
        self.Gia = gia
        self.DienThoai = dienthoai
        self.Image = image
        self.Nhom = nhom
        self.NoiBan = noiban
        self.NgayDang = ngaydang
}
}
