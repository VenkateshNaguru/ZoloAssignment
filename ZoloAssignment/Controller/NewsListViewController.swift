//
//  ViewController.swift
//  ZoloAssignment
//
//  Created by Venkatesh Naguru on 07/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import UIKit


let todoListCellID = "todoListTableViewCellID"
let postListCellID = "postListTableViewCellID"

protocol NewsDetailTextDelegate : class {
    func NewsDetailTextDelegate(title : String, body : String)
}

class NewsListViewController: UIViewController {
    private(set) var todoArray = [Todo]()
    private(set) var postArray = [Post]()
    private var newsListPresenter = NewsListPresenter()
    var selectedIndexString = ""
    @IBOutlet private weak var newListTableView: UITableView!
    weak var delegate : NewsDetailTextDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsListPresenter.delegate = self
        self.newListTableView.separatorStyle = .none
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.global(qos: .userInitiated).sync {
            self.newsListPresenter.loadNewsFromDB()
        }
        newListTableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: todoListCellID)
        newListTableView.register(PostListTableViewCell.self, forCellReuseIdentifier: postListCellID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsDetailSegue" {
            if let destination = segue.destination as? NewsDetailViewController {
                self.delegate = destination
            }
        }
    }
    
    
}

// MARK - Table View and Api calls delegates

extension NewsListViewController : UITableViewDelegate, UITableViewDataSource, TodoListDelegate, SelectedIndexDelegate {
    
    func todoListCallCompleted(todoList: [Todo], error: String?) {
        
        if error != nil {
            self.showAlert(message: error!)
            return
        }
        if todoList.count > 0 {
            todoArray = todoList
            DispatchQueue.main.async {
                self.newListTableView.reloadData()
            }
        }
        else {
            newsListPresenter.getTodoList()
            newsListPresenter.getPostList()
        }
    }
    
    func postListCallCompleted(postList: [Post], error: String?) {
        if error != nil {
            self.showAlert(message: error!)
            return
        }
        if postList.count > 0 {
            postArray = postList
            DispatchQueue.main.async {
                self.newListTableView.reloadData()
            }
        }
    }
    
    func selectedIndexNewsDetailText(newsTitle: String, newsBody: String) {
        self.delegate?.NewsDetailTextDelegate(title : newsTitle, body : newsBody)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        }
        else {
            return 240
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = newListTableView.dequeueReusableCell(withIdentifier: todoListCellID, for: indexPath) as! TodoListTableViewCell
            cell.todoArray = todoArray
            cell.todoListCollectionView.reloadData()
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: postListCellID, for: indexPath) as! PostListTableViewCell
            cell.postArray = postArray
            cell.postListCollectionView.reloadData()
            cell.delegate = self
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        header.textLabel?.frame = header.frame
        header.backgroundView?.backgroundColor = UIColor.white
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
             return "Text Data"
        }
        else {
            return "Text Data with Image"
        }
    }
    
    
    func showAlert(message : String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}



