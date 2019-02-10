//
//  NewsModel.swift
//  ZoloAssignment
//
//  Created by Venkatesh Naguru on 07/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import Foundation


struct Todo : Codable {
    var userId : Int
    var id : Int
    var title : String
    var completed : Bool
}

struct Post : Codable {
    var userId : Int
    var id : Int
    var title : String
    var body : String
}
