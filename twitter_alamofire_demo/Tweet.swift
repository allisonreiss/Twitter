//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation
import UIKit

class Tweet: NSObject {

    // MARK: Properties
    var profileImageUrl: URL?
    var user: User? // Contains the user's information
//    var handle: String?  // Contains screen name of tweet author
    var timeStamp: String? // Display date
    var text: String? // Text content of tweet
    var favoriteCount: Int = 0// Update favorite count label
    var retweetCount: Int = 0// Update favorite count label
    
    var id: String? // For favoriting, retweeting & replying
    var favorited: Bool // Configure favorite button
    var retweeted: Bool // Configure retweet button
    var tweetImageUrl: URL?
    
    // MARK: - Create initializer with dictionary
    init(dictionary: NSDictionary) {
        
        // Get the profile picture
        let profileUrlString = (dictionary["user"] as! NSDictionary)["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            self.profileImageUrl = URL(string:profileUrlString)
        }
        
        self.user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        let timeStampString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        if let timeStampString = timeStampString {
            let timeTweeted = formatter.date(from: timeStampString) as Date?
            let timeString = "\(timeTweeted!)"
            let endIndex = timeString.index(timeString.startIndex, offsetBy:10)
            self.timeStamp = timeString.substring(to: endIndex)
        }
        
        self.text = dictionary["text"] as? String
        self.id = dictionary["id"] as? String
        self.favoriteCount = (dictionary["favorite_count"] as? Int)!
        self.favorited = (dictionary["favorited"] as? Bool)!
        self.retweetCount = dictionary["retweet_count"] as! Int
        self.retweeted = dictionary["retweeted"] as! Bool
        
        //If there is an image, populate the tweetImageURL with displayURL.
        let entities = dictionary["entities"] as? NSDictionary
        let media = entities!["media"] as? NSDictionary
        if media != nil {
            let displayURL = media!["display_url"] as! String
            self.tweetImageUrl = URL.init(string: displayURL)
        }
    }
    
    // returns Tweets when initialized with an array of Tweet Dictionaries
    // Useful for every time you get back a response with an array of Tweet dictionaries
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets: [Tweet] = []
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}

