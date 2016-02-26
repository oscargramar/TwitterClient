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
            
            setTweetIcons()
           
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        //print("awake from jib")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setTweetIcons()
    }
    
    func setRetweeted(){
        self.tweet.retweeted = true
        self.tweet.retweetCount += 1
        print(self.tweet.retweetCount)
        if(tweet.retweetCount > 0){
            self.retweetCountLabel.hidden = false
        }
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
        //print("set selected")
    }
    func setTweetIcons(){
        //if it's my own tweet, I will disable the retweet button
        if(tweet.user?.userID! != User._currUser?.userID!){
            //If it's not a retweet or a protected tweet
            if(tweet.retweeted == false && (tweet.user?.protected)! == false){
                self.retweetButton.imageView!.image = UIImage(named: "retweet-action.png")
                self.userInteractionEnabled = true
                print("\(tweet.text) not a retweet and not a protected")
            }
            //if it's not a protected tweet  and not retweeted
            if((tweet.user?.protected) == true && tweet.retweeted == false){
                self.retweetButton.imageView!.image = UIImage(named: "retweet-action-inactive.png")
                self.userInteractionEnabled = false
            }
            //if it's retweeted
            if(tweet.retweeted == true){
                self.retweetButton.imageView!.image = UIImage(named: "retweet-action-on-pressed.png")
                self.userInteractionEnabled = true
            }
        }
            
        else{
            print("my own user")
            self.retweetButton.imageView!.image = UIImage(named: "retweet-action-inactive.png")
            self.retweetButton.userInteractionEnabled = false
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
