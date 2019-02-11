//
//  PostListTableViewCell.swift
//  ZoloAssignment
//
//  Created by Venkatesh Naguru on 09/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import UIKit

protocol SelectedIndexDelegate : class {
    func selectedIndexNewsDetailText(newsTitle : String, newsBody : String)
}

class PostListTableViewCell: UITableViewCell {
    var postArray = [Post]()
    @IBOutlet private weak var postListCollectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var postListCollectionView: UICollectionView!
    weak var delegate : SelectedIndexDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.postListCollectionView.delegate = self
        self.postListCollectionView.dataSource = self
        postListCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension PostListTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = postListCollectionView.dequeueReusableCell(withReuseIdentifier: "postListCollectionViewCellID", for: indexPath) as! PostListCollectionViewCell
        cell.postLabel.text = postArray[indexPath.row].title
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selectedIndexNewsDetailText(newsTitle : postArray[indexPath.row].title, newsBody : postArray[indexPath.row].body)
    }
    
    
    
}
