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
            
            retweetHolderCount = tweet!.retweetCount
            favHolderCount = tweet!.favoriteCount
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        tweet.favorited = true
        tweet.favoriteCount += 1
    }
    
    func refreshData() {
        if tweet!.favorited {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
        }
        favoriteCountLabel.text = "\(favHolderCount)"
        
        if tweet!.retweeted {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
        } else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
        }
        retweetCountLabel.text = "\(retweetHolderCount)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
