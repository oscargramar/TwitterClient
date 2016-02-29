//
//  User.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/16/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImageUrl: NSURL?
    var tagline: String?
    var dictionary: NSDictionary
    var userID: String?
    static var currUserDataKey = "currentUserData"
    static let userLoggedOutNotification = "UserDidLogout"
    static var _currUser:User?
    var protected = false
    
    var statusesCount = 0
    var numTweets = 0
    var numFollowing = 0
    var numFollowers = 0
    var backgroundImageUrl: NSURL?
    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileImageUrl = NSURL(string: profileUrlString)
        }
        tagline = dictionary["description"] as? String
        protected = (dictionary["protected"] as? Bool)!
        userID = dictionary["id_str"] as? String        
        
        let imgurl = dictionary["profile_background_image_url"] as? String
        if let imgurl = imgurl{
            backgroundImageUrl = NSURL(string: imgurl)
        }
        numTweets = dictionary["statuses_count"] as? Int ?? 0
        numFollowing = dictionary["friends_count"] as? Int ?? 0
        numFollowers = dictionary["followers_count"] as? Int ?? 0
        
        
        
        
        
    }
    class var currentUser:User?{
        get{
            if _currUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey(currUserDataKey)
                if let userData = userData{
                    let dictionary = try!NSJSONSerialization.JSONObjectWithData(userData as! NSData, options: []) as! NSDictionary
                    _currUser = User(dictionary: dictionary)
                }
        
            }
            return _currUser
        }
        
        set(user){
            let defaults = NSUserDefaults.standardUserDefaults()
            _currUser = user
            if let user = user{
                let data = try!NSJSONSerialization.dataWithJSONObject(user.dictionary, options: [])
                defaults.setObject(data, forKey: currUserDataKey)
                //_currUser = user

            }
            else{
                defaults.setObject(nil, forKey: currUserDataKey)
            }
            defaults.synchronize()
        }
    }
}
