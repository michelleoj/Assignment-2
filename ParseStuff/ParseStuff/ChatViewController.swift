//
//  ChatViewController.swift
//  ParseStuff
//
//  Created by michelle johnson on 9/9/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//
import Parse
import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [PFObject]?
    
    @IBAction func submitMessageAction(sender: AnyObject) {
        if messageTextField.text != nil {
            submitMessage()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        onTimer()
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageCell
        
        let message = messages![indexPath.row]
        println("message: \(message)")
        cell.messageLabel.text = message["text"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        } else {
            return 0
        }
    }
    
    func onTimer() {
        var query = PFQuery(className:"Message")
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    self.messages = objects
                    self.chatTableView.reloadData()
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
    func submitMessage() {
        var message = PFObject(className:"Message")
        message["text"] = messageTextField.text
        
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                println("message has been saved")
                self.messageTextField.text = nil
            } else {
                // There was a problem, check error.description
                println("message wasn't saved")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
