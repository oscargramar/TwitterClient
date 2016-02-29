//
//  ProfilePageViewController.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/28/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit

class ProfilePageViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileBackgroundImageView: UIImageView!
    @IBOutlet weak var profileImageview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenameLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    
    var userProfile: NSDictionary?
    var user: User?
    var tweets: [Tweet]!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Profile"
        navigationController?.navigationBar.barTintColor = UIColor(red: 64/255.0, green: 153/255.0, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        retrieveUserTimeline((user?.userID)!)
        retrieveUserProfile((user?.userID)!)
        definesPresentationContext = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets{
            return tweets.count
        }
        else{
            return 0
        }
    }
    
    func retrieveUserProfile(user_id:String){
        Twitter_API_Client.sharedInstance.showUser(user_id, success: { (dictionary) -> () in
            self.userProfile = dictionary
            self.setUserProfile()
            }) { (error:NSError) -> () in
                print(error.localizedDescription)
        }
    }
    
    func retrieveUserTimeline(user_id:String){
        Twitter_API_Client.sharedInstance.getUserTimeline(user_id, success: { (tweets:[Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            }) { (error:NSError) -> () in
                
                //
        }
    }
    
    func setUserProfile(){
        self.profileBackgroundImageView.setImageWithURL((user?.backgroundImageUrl)!)
        self.profileImageview.setImageWithURL((user?.profileImageUrl)!)
        self.numTweetsLabel.text = "\((user?.numTweets)!)"
        self.numFollowingLabel.text = "\((user?.numFollowing)!)"
        self.numFollowersLabel.text = "\((user?.numFollowers)!)"
        self.nameLabel.text = user?.name
        self.screenameLabel.text = "@\((user?.screenName)!)"
        
        self.numFollowersLabel.sizeToFit()
        self.numFollowingLabel.sizeToFit()
        self.numTweetsLabel.sizeToFit()
        self.nameLabel.sizeToFit()
        self.screenameLabel.sizeToFit()
        

    }
    
    @IBAction func favoritePressed(sender: AnyObject) {
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        
        Twitter_API_Client.sharedInstance.favorite(cell.tweet.id!, success: { (replyTweet: Tweet) -> () in
            cell.setFavorited()
            
            }) { (error:NSError) -> () in
                print(error.localizedDescription)
        }
        
        
        
    }
    @IBAction func retweetPressed(sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        
        
        Twitter_API_Client.sharedInstance.retweet(cell.tweet.id!, success: { (replyTweet: Tweet) -> () in
            cell.setRetweeted()
            
            
            
            
            }) { (error:NSError) -> () in
                //
                
                print(error.localizedDescription)
        }

        
    }
    
    

}
