//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/20/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit
class TweetsViewController: UIViewController {

    var tweets: [Tweet]!
    override func viewDidLoad() {
        super.viewDidLoad()
        Twitter_API_Client.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets{
                print(tweet.text)
            }
            
            
            }) { (error:NSError) -> () in
                //
        }
        
        
        
        // Do any additional setup after loading the view.
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
