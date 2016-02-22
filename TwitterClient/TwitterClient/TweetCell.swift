//
//  TweetTableViewCell.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/21/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var textTweetLabel: UILabel!
    
    
    
    
    var tweet: Tweet!{
        didSet{
            
            self.profileImageView.setImageWithURL((tweet.user?.profileImageUrl)!)
            self.nameLabel.text = tweet.user?.name
            self.screenNameLabel.text = "@\((tweet.user?.screenName)!)"
            self.textTweetLabel.text = tweet.text
            self.textTweetLabel.sizeToFit()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
