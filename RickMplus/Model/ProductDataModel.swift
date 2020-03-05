//
//  ProductDataModel.swift
//  RickM+
//
//  Created by RickSun on 2020/2/29.
//  Copyright © 2020 RickSun. All rights reserved.
//

import Foundation

struct AllProduct: Codable {
    
    var datas: [DataList]
    
}

struct DataList: Codable {
    
    var title: String
    
    var product: [ProductDetail]
    
}

struct ProductDetail: Codable {
    
    var name: String
    
    var price: Int
    
    var imageUrl: String
    
    var description: String
    
    var introduction: String
    
}
