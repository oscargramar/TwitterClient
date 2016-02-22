//
//  ViewController.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/15/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogin(sender: AnyObject) {
        Twitter_API_Client.sharedInstance.login({ () -> () in
            print("ive logged in")
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }) { (error:NSError) -> () in
                print(error.localizedDescription)
        
        
        }
        
        
//        Twitter_API_Client.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "codepathTwitterDemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
//            print("Got the request token")
//            
//            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
//            UIApplication.sharedApplication().openURL(authURL!)            
//            }) { (error: NSError!) -> Void in
//                print("failed to get request token")
//        }
        
    }


}

