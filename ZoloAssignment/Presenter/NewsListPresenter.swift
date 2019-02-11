//
//  NewsListPresenter.swift
//  ZoloAssignment
//
//  Created by Venkatesh Naguru on 07/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

protocol NewsListDelegate : class {
    func todoListCallCompleted(todoList : [Todo], error : String?)
    func postListCallCompleted(postList : [Post], error : String?)
}

struct NewsListPresenter {
    
    weak var delegate : NewsListDelegate?
    
    func getTodoList() {
        Alamofire.request(TODO_LIST_API).responseJSON { (response) in
            if response.result.isSuccess && response.data != nil {
                var newsListArray = [Todo]()
                do {
                    newsListArray = try JSONDecoder().decode([Todo].self, from: response.data!)
//                    print(newsListArray)
                    self.delegate?.todoListCallCompleted(todoList: newsListArray, error: nil)
                    self.saveTodoListToDB(todoListArray: newsListArray)
                }
                catch let error {
                    self.delegate?.todoListCallCompleted(todoList: newsListArray, error: error.localizedDescription)
                }
            }
        }
    }
    
    
    func getPostList() {
        Alamofire.request(POST_LIST_API).responseJSON { (response) in
            if response.result.isSuccess && response.data != nil {
                var postListArray = [Post]()
                do {
                    postListArray = try JSONDecoder().decode([Post].self, from: response.data!)
                    self.delegate?.postListCallCompleted(postList: postListArray, error: nil)
//                    print(postListArray)
                    self.savePostListToDB(postListArray: postListArray)
                }
                catch let error {
                    print(error)
                    self.delegate?.postListCallCompleted(postList: postListArray, error: error.localizedDescription)
                }
            }
        }
    }
    
    
    // MARK - save todoList to database
    
    func saveTodoListToDB(todoListArray : [Todo]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        for eachElement in todoListArray {
            let entity = NSEntityDescription.entity(forEntityName: "TodoEntity", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue(eachElement.id, forKey: "id")
            newUser.setValue(eachElement.userId, forKey: "userId")
            newUser.setValue(eachElement.title, forKey: "title")
            newUser.setValue(eachElement.completed, forKey: "completed")
        }
 
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    // MARK - save postList to database
    
    func savePostListToDB(postListArray : [Post]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        for eachElement in postListArray {
            let entity = NSEntityDescription.entity(forEntityName: "PostEntity", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue(eachElement.id, forKey: "id")
            newUser.setValue(eachElement.userId, forKey: "userId")
            newUser.setValue(eachElement.title, forKey: "title")
            newUser.setValue(eachElement.body, forKey: "body")
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    // MARK - load data from database
    func loadNewsFromDB() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let todoRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoEntity")
        let postRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostEntity")
        todoRequest.returnsObjectsAsFaults = false
        postRequest.returnsObjectsAsFaults = false
        var todoArray = [Todo]()
        do {
            let result = try context.fetch(todoRequest) as! [TodoEntity]
            for eachElement in result {
                let todo = Todo(userID: Int(eachElement.userId), id: Int(eachElement.id), title: eachElement.title!, completed: eachElement.completed)
                todoArray.append(todo)
            }
            self.delegate?.todoListCallCompleted(todoList: todoArray, error: nil)
        } catch {
            self.delegate?.todoListCallCompleted(todoList: todoArray, error: "Failed to fetch data")
        }
         var postArray = [Post]()
        do {
            let result = try context.fetch(postRequest) as! [PostEntity]
           
            for eachElement in result {
                let post = Post(userID: Int(eachElement.userId), id: Int(eachElement.id), title: eachElement.title!, body: eachElement.body!)
                postArray.append(post)
            }
            self.delegate?.postListCallCompleted(postList: postArray, error: nil)
        } catch {
            self.delegate?.postListCallCompleted(postList: postArray, error: "Failed to fetch data")
        }
    }
}
