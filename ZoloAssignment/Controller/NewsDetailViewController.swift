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
    
    @IBOutlet weak var newsDetailTextView: UITextView! {
        didSet {
            if selectedPost != nil {
                let fontAttribute : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28)]
                let newsString = NSMutableAttributedString(string: " \((selectedPost?.title)!) \n ", attributes: fontAttribute )
                let fontAttributeDetail : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                let bodyString = NSMutableAttributedString(string: (selectedPost?.body)!, attributes: fontAttributeDetail)
                newsString.append(bodyString)
                newsDetailTextView.attributedText = newsString
                newsDetailTextView.sizeToFit()
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

