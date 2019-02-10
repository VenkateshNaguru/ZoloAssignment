//
//  PostListTableViewCell.swift
//  ZoloAssignment
//
//  Created by Venkatesh Naguru on 09/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import UIKit

class PostListTableViewCell: UITableViewCell {
    var postArray = [Post]()
    @IBOutlet weak var postListCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.postListCollectionView.delegate = self
        self.postListCollectionView.dataSource = self
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
        cell.postLabel.text = postArray[indexPath.row].body
        return cell
    }
    
    
}
