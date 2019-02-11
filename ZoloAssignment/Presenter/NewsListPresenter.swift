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

protocol TodoListDelegate : class {
    func todoListCallCompleted(todoList : [Todo])
    func postListCallCompleted(postList : [Post])
}

struct NewsListPresenter {
    
    weak var delegate : TodoListDelegate?
    
    func getTodoList() {
        Alamofire.request(TODO_LIST_API).responseJSON { (response) in
            if response.result.isSuccess {
                do {
                    let newsListArray = try JSONDecoder().decode([Todo].self, from: response.data!)
//                    print(newsListArray)
                    self.delegate?.todoListCallCompleted(todoList: newsListArray)
                    self.saveTodoListToCoreData(todoListArray: newsListArray)
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    
    
    func getPostList() {
        Alamofire.request(POST_LIST_API).responseJSON { (response) in
            if response.result.isSuccess {
                do {
                    let postListArray = try JSONDecoder().decode([Post].self, from: response.data!)
                    self.delegate?.postListCallCompleted(postList: postListArray)
//                    print(postListArray)
                    self.savePostListToCoreData(postListArray: postListArray)
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    
    
    // MARK - save todoList to database
    
    func saveTodoListToCoreData(todoListArray : [Todo]) {
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
    
    func savePostListToCoreData(postListArray : [Post]) {
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
        do {
            let result = try context.fetch(todoRequest) as! [TodoEntity]
            var todoArray = [Todo]()
            for eachElement in result {
                let todo = Todo(userID: Int(eachElement.userId), id: Int(eachElement.id), title: eachElement.title!, completed: eachElement.completed)
                todoArray.append(todo)
            }
            self.delegate?.todoListCallCompleted(todoList: todoArray)
        } catch {
            print("Failed")
        }
        
        do {
            let result = try context.fetch(postRequest) as! [PostEntity]
            var postArray = [Post]()
            for eachElement in result {
                let post = Post(userID: Int(eachElement.userId), id: Int(eachElement.id), title: eachElement.title!, body: eachElement.body!)
                postArray.append(post)
            }
            self.delegate?.postListCallCompleted(postList: postArray)
        } catch {
            print("Failed")
        }
    }
}
