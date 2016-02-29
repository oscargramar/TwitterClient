//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/20/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit
class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Home"
        navigationController?.navigationBar.barTintColor = UIColor(red: 64/255.0, green: 153/255.0, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        reloadHomeTimeline()
        definesPresentationContext = true
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        
        let profileImageTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleProfileTapped:"))
        profileImageTapRecognizer.cancelsTouchesInView = true
        cell.profileImageView?.tag = indexPath.row
        profileImageTapRecognizer.numberOfTapsRequired = 1
        profileImageTapRecognizer.delegate = self
        cell.profileImageView?.userInteractionEnabled = true
        cell.profileImageView?.addGestureRecognizer(profileImageTapRecognizer)
        
        
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogoutButton(sender: AnyObject) {
        Twitter_API_Client.sharedInstance.logout()  
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
    func reloadHomeTimeline(){
        Twitter_API_Client.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            }) { (error:NSError) -> () in
                //
        }
    }

    
    
    
    func handleProfileTapped(tapRecognizer: UITapGestureRecognizer){
        self.performSegueWithIdentifier("profileSegue", sender:tapRecognizer)
        
        
        
        
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? TweetCell{
            let detailsVC = segue.destinationViewController as! TweetDetailViewController
            detailsVC.tweet = cell.tweet
        }
        else if let profileTap = sender as? UITapGestureRecognizer{
            let profilePageVC = segue.destinationViewController as! ProfilePageViewController
            if let cell =  profileTap.view?.superview?.superview as? TweetCell{
                profilePageVC.tweet = cell.tweet

            }
        }
        
        
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
