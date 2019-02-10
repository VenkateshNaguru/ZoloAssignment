//
//  TodoListTableViewCell.swift
//  ZoloAssignment
//
//  Created by Venkatesh Naguru on 09/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoListCollectionViewLayout: UICollectionViewFlowLayout!
    
    var todoArray = [Todo]()
    @IBOutlet weak var todoListCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.todoListCollectionView.delegate = self
        self.todoListCollectionView.dataSource = self
        todoListCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension TodoListTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = todoListCollectionView.dequeueReusableCell(withReuseIdentifier: "todoListCollectionViewCellID", for: indexPath) as! TodoListCollectionViewCell
        cell.todoLabel.text = todoArray[indexPath.row].title
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    
}
