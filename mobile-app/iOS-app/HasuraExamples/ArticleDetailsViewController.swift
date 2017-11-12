//
//  ArticleDetailsViewController.swift
//  iOS-app
//
//  Created by Jaison on 03/11/17.
//  Copyright © 2017 Hasura. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var textview: UITextView!
    
    var articleTitle: String!
    var articleContent: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = articleTitle
        textview.text = articleContent
    }
    
    func setData(title: String, content: String) {
        self.articleTitle = title
        self.articleContent = content
    }
    
}
