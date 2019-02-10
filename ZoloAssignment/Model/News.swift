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
    
    init(userID : Int, id : Int, title : String, completed : Bool) {
        self.userId = userID
        self.id = id
        self.title = title
        self.completed = completed
    }
}

struct Post : Codable {
    var userId : Int
    var id : Int
    var title : String
    var body : String
    
    init(userID : Int, id : Int, title : String, body : String) {
        self.userId = userID
        self.id = id
        self.title = title
        self.body = body
    }
}
