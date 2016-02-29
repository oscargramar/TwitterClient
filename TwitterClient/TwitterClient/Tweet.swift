//
//  Tweet.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/16/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var id:String?
    var text: String?
    var timestamp: NSDate?
    var retweetCount:Int = 0
    var favoritesCount:Int = 0
    var dictionary:NSDictionary?
    var retweeted = false
    var favorited = false
    var inReplyToScreename: String?
    
    init(dictionary:NSDictionary) {
        
        
        self.dictionary = dictionary
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        let timestamp_string = dictionary["created_at"] as? String
        if let timestamp_string = timestamp_string{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
            timestamp = formatter.dateFromString(timestamp_string)
        }
        id = dictionary["id_str"] as? String
        retweeted = (dictionary["retweeted"] as? Bool)!
        favorited = (dictionary["favorited"] as? Bool)!
        inReplyToScreename = dictionary["in_reply_to_screen_name"] as? String
    }
    class func tweetsWithArray (dictionaries:[NSDictionary]) ->[Tweet]{
        var tweets = [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
