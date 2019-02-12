//
//  NewsDetailViewController.swift
//  ZoloAssignment
//
//  Created by Venkatesh Naguru on 10/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    var selectedPost : Post?
    
    
    @IBOutlet private weak var newsDetailLabel: UILabel! {
        didSet {
            if selectedPost != nil {
                let fontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28)]
                
                let newsString = NSMutableAttributedString(string: " \((selectedPost?.title)!) \n ", attributes: fontAttribute as [NSAttributedString.Key : Any] )
                let fontAttributeDetail = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                let bodyString = NSMutableAttributedString(string: (selectedPost?.body)!, attributes: fontAttributeDetail as [NSAttributedString.Key : Any] )
                newsString.append(bodyString)
                newsDetailLabel.attributedText = newsString
                newsDetailLabel.sizeToFit()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

