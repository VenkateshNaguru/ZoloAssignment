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


class NewsListViewController: UIViewController {
    private(set) var todoArray = [Todo]()
    private(set) var postArray = [Post]()
    private var newsListPresenter = NewsListPresenter()
    @IBOutlet private weak var newsListActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var newListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        newsListPresenter.delegate = self
        DispatchQueue.global(qos: .userInitiated).sync {
            self.newsListPresenter.loadNewsFromDB()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.newListTableView.separatorStyle = .none
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.newsListActivityIndicator.isHidden = false
        self.newsListActivityIndicator.startAnimating()
        newListTableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: todoListCellID)
        newListTableView.register(PostListTableViewCell.self, forCellReuseIdentifier: postListCellID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsDetailSegue" {
            if let destination = segue.destination as? NewsDetailViewController {
                destination.selectedPost = sender as? Post
            }
        }
    }
    
    
}

// MARK - Table View and Api calls delegates

extension NewsListViewController : UITableViewDelegate, UITableViewDataSource, NewsListDelegate, SelectedIndexDelegate {
    func selectedIndexNewsDetail(selectedPost: Post) {
        performSegue(withIdentifier: "newsDetailSegue", sender: selectedPost)
    }
    
    
    func todoListCallCompleted(todoList: [Todo], error: String?) {
        
        if error != nil {
            self.showAlert(message: error!)
            return
        }
        if todoList.count > 0 {
            todoArray = todoList
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
        else {
            DispatchQueue.global(qos: .userInitiated).sync {
                newsListPresenter.getTodoList()
                newsListPresenter.getPostList()
            }
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
                self.updateUI()
            }
        }
    }
    
    func updateUI() {
        self.newsListActivityIndicator.stopAnimating()
        if !self.newsListActivityIndicator.isHidden {
            self.newsListActivityIndicator.isHidden = true
        }
        self.newListTableView.reloadData()
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
        if section == 0 && todoArray.count > 0{
             return "Text Data"
        }
        else if postArray.count > 0 {
            return "Text Data with Image"
        }
        
        return nil
    }
    
    
    func showAlert(message : String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}



