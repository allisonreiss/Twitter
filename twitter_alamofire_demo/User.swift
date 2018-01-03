//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var tagline: String?
    var backgroundUrl: URL?
    var userID: String?
    var followers: Int = 0
    var following: Int = 0
    var tweetCount: Int = 0
    
    var dictionary: NSDictionary?
    
    static var _currentUser: User?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        self.name = dictionary["name"] as? String
        self.screenName = dictionary["screen_name"] as? String
        self.tagline = dictionary["description"] as? String
        self.userID = dictionary["id_str"] as? String
        self.followers = dictionary["followers_count"] as! Int
        self.following = dictionary["friends_count"] as! Int
        self.tweetCount = dictionary["statuses_count"] as! Int
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            self.profileUrl = URL(string: profileUrlString)
        }
        
        let backgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundUrlString = backgroundUrlString {
            self.backgroundUrl = URL(string: backgroundUrlString)
        }
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil{
                let defaults = UserDefaults.standard
                let userData = defaults.value(forKey: "currentUserData")
                
                if let userData = userData {
                    
                    let dict = try! JSONSerialization.jsonObject(with: userData as! Data, options: [])
                    
                    _currentUser = User(dictionary: dict as! NSDictionary)
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data,forKey: "currentUserData" )
            } else{
                defaults.set(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
}
