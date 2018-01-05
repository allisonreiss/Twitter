//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Allison Reiss on 1/4/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController {

    weak var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        let url = User.currentUser!.profileUrl
        let data = try? Data(contentsOf: url!)
        profileImageView.image = UIImage(data: data!)
    }

    @objc func handleKeyboardShows(notification: NSNotification) {
        
        if (tweetText.text == "") || (tweetText.text == "What's Happening?") {
            tweetText.text = ""
        }
        
    }
    
    @objc func handleKeyboardHides(notification: NSNotification) {
        if tweetText.text == "" {
            tweetText.text = "What's Happening?"
        }
    }
    
    
    @IBAction func onTapCancel(_ sender: Any) {
        tweetText.text = "What's Happening?";
        
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func onTapTweet(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetText.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
