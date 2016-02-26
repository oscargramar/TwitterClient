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
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    
    var tweet: Tweet!{
        didSet{
            print("tweetdidSet")
            self.favoritesCountLabel.text = "\(tweet.favoritesCount)"
            self.retweetCountLabel.text = "\(tweet.retweetCount)"
            if(tweet.retweetCount == 0){
                self.retweetCountLabel.hidden = true
            }
            else{
                self.retweetCountLabel.hidden = false
            }
            
            self.profileImageView.setImageWithURL((tweet.user?.profileImageUrl)!)
            self.nameLabel.text = tweet.user?.name
            self.screenNameLabel.text = "@\((tweet.user?.screenName)!)"
            self.textTweetLabel.text = tweet.text
            self.textTweetLabel.sizeToFit()
            
            
            //If it's not a retweet or a protected tweet
            if(tweet.retweeted == false && (tweet.user?.protected)! == false){
                self.retweetButton.imageView!.image = UIImage(named: "retweet-action.png")
            }
            
            //if it's not a tweet  and not retweeted
            if((tweet.user?.protected) == true && tweet.retweeted == false){
                self.retweetButton.imageView!.image = UIImage(named: "retweet-action-inactive.png")
            }
            
            //if it's retweeted
            if(tweet.retweeted == true){
                self.retweetButton.imageView!.image = UIImage(named: "retweet-action-on-pressed.png")
            }
            
            //if it's favorited
            if(tweet.favorited == true){
                self.favoriteButton.imageView!.image = UIImage(named: "like-action-on-pressed.png")
            }
                //if it's a regular tweet
            else{
                self.favoriteButton.imageView!.image = UIImage(named: "like-action.png")
            }
            
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        print("awake from jib")
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
        if(tweet.favorited == true){
            self.favoriteButton.imageView!.image = UIImage(named: "like-action-on-pressed.png")
        }
        else{
            self.favoriteButton.imageView!.image = UIImage(named: "like-action.png")
        }
        
//        if(isFavorited){
//            self.favoritesCountLabel.text = "\(self.tweet.favoritesCount + 1)"
//            self.favoriteButton.imageView!.image = UIImage(named: "like-action-on-pressed.png")
//        }
        
        
    }
    
    func setRetweeted(){
        self.tweet.retweeted = true
        self.tweet.retweetCount += 1
        print(self.tweet.retweetCount)
        if(tweet.retweetCount > 0){
            self.retweetCountLabel.hidden = false
        }
//        else{
//            self.retweetCountLabel.hidden = false
//        }
        self.retweetButton.imageView!.image = UIImage(named: "retweet-action-on-pressed.png")
        self.retweetCountLabel.text = "\(tweet.retweetCount)"
        
        
    }
    func setFavorited(){
            self.tweet.favorited = true
            self.tweet.favoritesCount += 1
            self.favoritesCountLabel.text = "\(self.tweet.favoritesCount)"
            self.favoriteButton.imageView!.image = UIImage(named: "like-action-on-pressed.png")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        print("set selected")
    }

}
