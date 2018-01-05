//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
 
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favHolderCount: Int = 0
    var retweetHolderCount: Int = 0
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet!.user!.name! as String
            handleLabel.text = tweet.user!.screenName! as String
            timeLabel.text = ("･ \(String(describing: tweet.timeStamp!))")
            retweetCountLabel.text = "\(String(describing: tweet.retweetCount))"
            favoriteCountLabel.text = "\(String(describing: tweet.favoriteCount))"
            
            let url = tweet!.user!.profileUrl
            let data = try? Data(contentsOf: url!)
            profileImageView.image = UIImage(data: data!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if tweet!.retweeted {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            refreshData()
            
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.retweeted = true
            tweet.retweetCount += 1
            refreshData()
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeting the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        if tweet!.favorited {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            refreshData()
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.favorited = true
            tweet.favoriteCount += 1
            refreshData()
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        
    }
    
    func refreshData() {
        if tweet!.favorited {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            favoriteCountLabel.text = String(describing:tweet.favoriteCount)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
            favoriteCountLabel.text = String(describing:tweet.favoriteCount)
        }
        favoriteCountLabel.text = "\(favHolderCount)"
        
        if tweet!.retweeted {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            retweetCountLabel.text = String(describing:tweet.retweetCount)
        } else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            retweetCountLabel.text = String(describing:tweet.retweetCount)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
