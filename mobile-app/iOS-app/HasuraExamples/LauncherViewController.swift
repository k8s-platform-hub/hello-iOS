//
//  LauncherViewController.swift
//  iOS-app
//
//  Created by Jaison on 03/11/17.
//  Copyright © 2017 Hasura. All rights reserved.
//

import UIKit

class LauncherViewController: UIViewController {
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onAuthenticateClicked(_ sender: UIButton) {
        if let authVC = storyBoard.instantiateViewController(withIdentifier: "AuthNavVC") as? UINavigationController {
            self.present(authVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func onViewArticlesClicked(_ sender: UIButton) {
        if let articlesVC = storyBoard.instantiateViewController(withIdentifier: "ArticleNavVC") as? UINavigationController {
            self.present(articlesVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func onFilestoreClicked(_ sender: UIButton) {
        if let articlesVC = storyBoard.instantiateViewController(withIdentifier: "FilestoreNavVC") as? UINavigationController {
            self.present(articlesVC, animated: true, completion: nil)
        }
    }
    
}
