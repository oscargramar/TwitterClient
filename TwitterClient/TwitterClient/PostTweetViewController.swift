//
//  PostTweetViewController.swift
//  TwitterClient
//
//  Created by Oscar G.M on 2/28/16.
//  Copyright © 2016 GMStudios. All rights reserved.
//

import UIKit

class PostTweetViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        print("cancel")
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func tweetPressed(sender: AnyObject) {
        if(textView.hasText()){
            Twitter_API_Client.sharedInstance.postStatus(textView.text, success: { () -> () in
                 self.navigationController?.popViewControllerAnimated(true)
                }, failure: { (error:NSError) -> () in
                    //
                    
            })
           
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
