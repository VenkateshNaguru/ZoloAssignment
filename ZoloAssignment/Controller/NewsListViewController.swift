//
//  ViewController.swift
//  ZoloAssignment
//
//  Created by Venkatesh Naguru on 07/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {
    private(set) var todoArray = [Todo]()
    private(set) var postArray = [Post]()
    private var newsListPresenter = NewsListPresenter()
    @IBOutlet private weak var newListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsListPresenter.delegate = self
        newsListPresenter.getTodoList()
        newsListPresenter.getPostList()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        newListTableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: "todoListTableViewCellID")
        newListTableView.register(PostListTableViewCell.self, forCellReuseIdentifier: "postListTableViewCellID")
    }
}

extension NewsListViewController : UITableViewDelegate, UITableViewDataSource, TodoListDelegate {
    func postListCallCompleted(postList: [Post]) {
        postArray = postList
        newListTableView.reloadData()
    }
    
    
    func todoListCallCompleted(todoList : [Todo]) {
        todoArray = todoList
        newListTableView.reloadData()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        }
        else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = newListTableView.dequeueReusableCell(withIdentifier: "todoListTableViewCellID", for: indexPath) as! TodoListTableViewCell
            cell.todoArray = todoArray
            cell.todoListCollectionView.reloadData()
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postListTableViewCellID", for: indexPath) as! PostListTableViewCell
            cell.postArray = postArray
            cell.postListCollectionView.reloadData()
            return cell
        }
       
    }
    
    
}



