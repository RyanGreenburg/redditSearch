//
//  PostListTableViewController.swift
//  redditSearch
//
//  Created by RYAN GREENBURG on 2/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    var posts: [RLGPost] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        
        let post = posts[indexPath.row]
        cell?.post = post
        RLGPostController.fetchImage(for: post) { (image) in
            DispatchQueue.main.async {
                cell?.postImageView?.image = image
            }
        }
        
        return cell ?? UITableViewCell()
    }
}

extension PostListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        RLGPostController.fetchPosts(forSearchTerm: searchTerm) { (posts) in
            guard let posts = posts else { return }
            self.posts = posts
        }
    }
}
