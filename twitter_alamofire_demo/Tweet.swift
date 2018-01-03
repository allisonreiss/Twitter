//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class Tweet {
/*
    // MARK: Properties
    var ProfileImageURL: URL
    var user: User // Contains name, screenname, etc. of tweet author
    var handle: String?
    var createdAtString: String // Display date
    var text: String // Text content of tweet
    var favoriteCount: Int = 0// Update favorite count label
    var retweetCount: Int = 0// Update favorite count label
    
    var id: Int? // For favoriting, retweeting & replying
    var favorited: Bool? // Configure favorite button
    var retweeted: Bool // Configure retweet button

    // For Retweets
    var retweetedByUser: User? // user who retweeted if tweet is retweet
    
    // MARK: - Create initializer with dictionary
    init(dictionary: [String: Any]) {
        var dictionary = dictionary
        
        //is this a retweet?
        if let originalTweet = dictionary["retweeted_status"] as? [String: Any] {
            let userDictionary = dictionary["user"] as! [String:Any]
            self.retweetedByUser = User(dictionary: userDictionary)
            
            //change tweet to original tweet
            dictionary = originalTweet
        }
        
        id = dictionary["id"] as! Int?
        text = dictionary["text"] as! String
        favoriteCount = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as! Int
        retweeted = dictionary["retweeted"] as! Bool
        
        
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        handle = ("@" + "\(user.screenName!)")
        
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String
        createdAtString = formatter.string(from: date)
        
        //If there is an image, populate the tweetImageURL with displayURL.
        let entities = dictionary["entities"] as? NSDictionary
        let media = entities!["media"] as? NSDictionary
        if media != nil {
            let displayURL = media!["display_url"] as! String
            tweetImageURL = URL.init(string: displayURL)
            print(tweetImageURL!)
        }
    }
    
    // returns Tweets when initialized with an array of Tweet Dictionaries
    // Useful for every time you get back a response with an array of Tweet dictionaries
    static func tweets(with array: [[String: Any]]) -> [Tweet] {
        var tweets: [Tweet] = []
        for tweetDictionary in array {
            let tweet = Tweet(dictionary: tweetDictionary)
            tweets.append(tweet)
        }
        return tweets
    }
 
*/
}

