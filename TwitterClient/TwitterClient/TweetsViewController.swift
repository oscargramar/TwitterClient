//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/20/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit
class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        
        Twitter_API_Client.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
//            for tweet in self.tweets{
//                print(tweet.text)
//           }
            self.tableView.reloadData()
            
            }) { (error:NSError) -> () in
                //
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
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
    

    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
