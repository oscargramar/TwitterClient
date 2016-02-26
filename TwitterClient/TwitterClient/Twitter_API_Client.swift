//
//  Twitter_API_Client.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/15/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class Twitter_API_Client:BDBOAuth1SessionManager{
    static let sharedInstance = Twitter_API_Client(baseURL:NSURL(string:"https://api.twitter.com"),consumerKey:"uMSntYKgmhsn0ymUI6wnrKM7j", consumerSecret: "ces8uoWoOMBJmEm2nFLiZWQFrqOujFRJxszf8mOnb3xDF21KQY")
    var loginSuccess: (()->())?
    var loginFailure: ((NSError)->())?
    
    
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()){

        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil,  success: { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            print("success")
            success(tweets)
        }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
                print(error.localizedDescription)
        })
    }
    
    
    func retweet(id_string:String, success:(replyTweet:Tweet)->(), failure: (NSError)->()){
        
        POST("1.1/statuses/retweet/\(id_string).json", parameters: nil, progress: nil, success: { (operation:NSURLSessionDataTask?, response: AnyObject?) -> Void in
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            success(replyTweet: tweet)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    func favorite(id_string:String, success:(replyTweet:Tweet)->(), failure:(NSError)->()){
        POST("1.1/favorites/create.json?id=\(id_string)", parameters: nil, progress: nil, success: { (operation:NSURLSessionDataTask?, response:AnyObject?) -> Void in
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            success(replyTweet: tweet)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    
    func currentAccount(success:(User)->(), failure:(NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
            let user = User(dictionary: response as! NSDictionary)
            success(user)
        }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })

    }
    
    func handleOpenUrl(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query) , success: { (accessToken:BDBOAuth1Credential!) -> Void in
            print("got the access token")
            Twitter_API_Client.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            self.currentAccount({ (user:User) -> () in
                User.currentUser = user
                
                
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
                })
            }) { (error: NSError!) -> Void in
                print("failed to receive the access token")
                self.loginFailure?(error)
        }
    }
    
    
    func login(success:() -> (), failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "codepathTwitterDemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("failed to get request token")
                self.loginFailure?(error)
        }
    }
    func logout(){
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userLoggedOutNotification, object: nil)
    }
}