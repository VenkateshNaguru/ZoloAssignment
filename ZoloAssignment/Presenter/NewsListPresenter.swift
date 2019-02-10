//
//  NewsListPresenter.swift
//  ZoloAssignment
//
//  Created by Venkatesh Naguru on 07/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import Foundation
import Alamofire

protocol TodoListDelegate : class {
    func todoListCallCompleted(todoList : [Todo])
    func postListCallCompleted(postList : [Post])
}

struct NewsListPresenter {
    
    weak var delegate : TodoListDelegate?
    
    func getTodoList() {
        Alamofire.request("https://jsonplaceholder.typicode.com/todos").responseJSON { (response) in
            if response.result.description == "SUCCESS" {
                do {
                    let newsListArray = try JSONDecoder().decode([Todo].self, from: response.data!)
                    print(newsListArray)
                    self.delegate?.todoListCallCompleted(todoList: newsListArray)
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    
    
    func getPostList() {
        Alamofire.request("https://jsonplaceholder.typicode.com/posts").responseJSON { (response) in
            if response.result.description == "SUCCESS" {
                do {
                    let postListArray = try JSONDecoder().decode([Post].self, from: response.data!)
                    self.delegate?.postListCallCompleted(postList: postListArray)
                    print(postListArray)
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
}
