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
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    var tweet: Tweet!{
        didSet{
            
            
            self.retweetedLabel.hidden = !tweet.retweeted
            
            self.profileImageView.setImageWithURL((tweet.user?.profileImageUrl)!)
            self.nameLabel.text = tweet.user?.name
            self.screenNameLabel.text = "@\((tweet.user?.screenName)!)"
            self.textTweetLabel.text = tweet.text
            self.textTweetLabel.sizeToFit()
            if(tweet.retweeted == false && (tweet.user?.protected)! == false){
                self.retweetButton.imageView!.image = UIImage(named: "retweet-action.png")
            }
            
            if((tweet.user?.protected) == true && tweet.retweeted == false){
                self.retweetButton.imageView!.image = UIImage(named: "retweet-action-inactive.png")
            }
            if(tweet.retweeted == true){
                self.retweetButton.imageView!.image = UIImage(named: "retweet-action-on-pressed.png")
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        //nameLabel.preferredMaxLayoutWidth = nameLabel.frame.width
   
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //nameLabel.preferredMaxLayoutWidth = nameLabel.frame.width
        if(tweet.retweeted == false && (tweet.user?.protected)! == false){
            self.retweetButton.imageView!.image = UIImage(named: "retweet-action.png")
        }
        
        if((tweet.user?.protected) == true && tweet.retweeted == false){
            self.retweetButton.imageView!.image = UIImage(named: "retweet-action-inactive.png")
        }
        if(tweet.retweeted == true){
            self.retweetButton.imageView!.image = UIImage(named: "retweet-action-on-pressed.png")
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
