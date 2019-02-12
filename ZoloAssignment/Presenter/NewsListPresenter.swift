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
                var todoListArray = [Todo]()
                do {
                    todoListArray = try JSONDecoder().decode([Todo].self, from: response.data!)
//                    print(newsListArray)
                    self.delegate?.todoListCallCompleted(todoList: todoListArray, error: nil)
                    self.saveTodoListToDB(todoListArray: todoListArray)
                }
                catch let error {
                    self.delegate?.todoListCallCompleted(todoList: todoListArray, error: error.localizedDescription)
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
    
    private func saveTodoListToDB(todoListArray : [Todo]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        for eachElement in todoListArray {
            let entity = NSEntityDescription.entity(forEntityName: "TodoEntity", in: context)
            let newTodoItem = NSManagedObject(entity: entity!, insertInto: context)
            
            newTodoItem.setValue(eachElement.id, forKey: "id")
            newTodoItem.setValue(eachElement.userId, forKey: "userId")
            newTodoItem.setValue(eachElement.title, forKey: "title")
            newTodoItem.setValue(eachElement.completed, forKey: "completed")
        }
 
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    // MARK - save postList to database
    
    private func savePostListToDB(postListArray : [Post]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        for eachElement in postListArray {
            let entity = NSEntityDescription.entity(forEntityName: "PostEntity", in: context)
            let newPost = NSManagedObject(entity: entity!, insertInto: context)
            
            newPost.setValue(eachElement.id, forKey: "id")
            newPost.setValue(eachElement.userId, forKey: "userId")
            newPost.setValue(eachElement.title, forKey: "title")
            newPost.setValue(eachElement.body, forKey: "body")
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
