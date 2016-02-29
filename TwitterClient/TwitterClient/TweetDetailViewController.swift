//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/23/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var timestampLabel: UILabel!
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTweetDetailView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        setTweetIcons()
    }
    
    func setUpTweetDetailView(){
        self.profileImageView.setImageWithURL((tweet!.user?.profileImageUrl)!)
        self.profileNameLabel.text = tweet!.user?.name
        self.textLabel.text = tweet!.text
        self.favoritesCountLabel.text = "\(tweet!.favoritesCount)"
        self.retweetCountLabel.text = "\(tweet!.retweetCount)"
        self.usernameLabel.text = "@\((tweet!.user?.screenName)!)"
        
        
        let date = tweet!.timestamp
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd HH:mm yyyy"
        let dateString = dateFormatter.stringFromDate(date!)
        self.timestampLabel.text = dateString
    }
    
    @IBAction func replyPressed(sender: AnyObject) {
    }

    @IBOutlet weak var retweetPressed: UIButton!
    
    @IBAction func favoritePressed(sender: AnyObject) {
    }
    
    func setTweetIcons(){
        print(tweet!.favorited)
        //if it's my own tweet, I will disable the retweet button
        if(tweet!.user?.userID! != User._currUser?.userID!){
            //If it's not a retweet or a protected tweet
            if(tweet!.retweeted == false && (tweet!.user?.protected)! == false){
                retweetButton.imageView!.image = UIImage(named: "retweet-action.png")
                retweetButton.userInteractionEnabled = true
             
            }
            //if it's not a protected tweet  and not retweeted
            if((tweet!.user?.protected) == true && tweet!.retweeted == false){
                retweetButton.imageView!.image = UIImage(named: "retweet-action-inactive.png")
                retweetButton.userInteractionEnabled = false
            }
            //if it's retweeted
            if(tweet!.retweeted == true){
                retweetButton.imageView!.image = UIImage(named: "retweet-action-on-pressed.png")
                retweetButton.userInteractionEnabled = true
            }
        }
            
        else{
            retweetButton.imageView!.image = UIImage(named: "retweet-action-inactive.png")
            retweetButton.userInteractionEnabled = false
        }
        
        //if it's favorited
        if(tweet!.favorited == true){
            favoriteButton.imageView!.image = UIImage(named: "like-action-on-pressed.png")
        }
            //if it's a regular tweet
        else{
            favoriteButton.imageView!.image = UIImage(named: "like-action.png")
        }
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
