//
//  Twitter_API_Client.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/15/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "uMSntYKgmhsn0ymUI6wnrKM7j"
let twitterConsumerSecret = "ces8uoWoOMBJmEm2nFLiZWQFrqOujFRJxszf8mOnb3xDF21KQY"
let twitterBaseURL = NSURL(string:"https://api.twitter.com")



class Twitter_API_Client: BDBOAuth1SessionManager {
    class var sharedInstance: Twitter_API_Client{
        struct Static{
            static let instance = Twitter_API_Client(baseURL:twitterBaseURL,consumerKey:twitterConsumerKey, consumerSecret:twitterConsumerSecret)
        }
        return Static.instance
    }
    

}
