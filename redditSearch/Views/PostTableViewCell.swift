//
//  PostTableViewCell.swift
//  redditSearch
//
//  Created by RYAN GREENBURG on 2/13/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var post: RLGPost? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upvotesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    func updateViews() {
        guard let post = post else { return }
        titleLabel.text = post.title
        upvotesLabel.text = "\(post.upvotes) upvotes"
        commentsLabel.text = "\(post.comments) comments"
    }
}
