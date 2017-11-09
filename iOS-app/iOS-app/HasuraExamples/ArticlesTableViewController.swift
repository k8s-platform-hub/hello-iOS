//
//  ArticlesTableViewController.swift
//  iOS-app
//
//  Created by Jaison on 03/11/17.
//  Copyright © 2017 Hasura. All rights reserved.
//

import UIKit
import Alamofire

class ArticlesTableViewController: UITableViewController {

    var data = [[String: Any]]()
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fetch all articles from table article
        Alamofire.request(
            Hasura.URL.data.getURL() + "v1/query",
            method: HTTPMethod.post,
            parameters: [
                "type": "select",
                "args": [
                    "table": "article",
                    "columns": [
                        "*"
                    ]
                ]
            ],
            encoding: JSONEncoding.default,
            headers: nil)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    if let responseArray = value as? [[String: Any]] {
                        self.data = responseArray
                        self.tableView.reloadData()
                    }
                    break
                case .failure(let error):
                    self.showAlert(title: "Failed to fetch data", message: error.localizedDescription)
                    break
                }
        }
    }
    
    @IBAction func onCancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleData = data[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: "articleCell") as! UITableViewCell)
        cell.textLabel?.text = (articleData["title"] as! String)
        cell.detailTextLabel?.text = (articleData["content"] as! String)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleData = data[indexPath.row]
        let articleTitle = (articleData["title"] as! String)
        let articleContent = (articleData["content"] as! String)
        let articleDetailsVC = storyBoard.instantiateViewController(withIdentifier: "articleDetailVC") as! ArticleDetailsViewController
        articleDetailsVC.setData(title: articleTitle, content: articleContent)
        self.navigationController?.pushViewController(articleDetailsVC, animated: true)
    }

}
