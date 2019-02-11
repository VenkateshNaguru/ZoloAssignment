//
//  NewsDetailViewController.swift
//  ZoloAssignment
//
//  Created by Venkatesh Naguru on 10/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    var newsTitleString = ""
    var newsBodyString = ""
    
    @IBOutlet private weak var newsTitleView: UITextView! {
        didSet {
            newsTitleView.text = newsTitleString
            adjustUITextViewHeight(textView: newsTitleView)
        }
    }

    @IBOutlet private weak var newsDetailTextView: UITextView! {
        didSet {
            newsDetailTextView.text = newsBodyString
            adjustUITextViewHeight(textView: newsDetailTextView)
        }
    }
    
    private func adjustUITextViewHeight(textView : UITextView)
    {
        var frame = textView.frame
        frame.size.height = textView.contentSize.height
        textView.frame = frame
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}


extension NewsDetailViewController : NewsDetailTextDelegate {
    func NewsDetailTextDelegate(title: String, body: String) {
        newsTitleString = title
        newsBodyString = body
    }
    
    
}
