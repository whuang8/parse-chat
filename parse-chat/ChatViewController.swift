//
//  ChatViewController.swift
//  parse-chat
//
//  Created by William Huang on 2/23/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        let message = PFObject(className:"Message")
        message["text"] = messageField.text
        
        message.saveInBackground { (success: Bool, error: Error?) in
            if (success) {
                print(message)
                // The object has been saved.
            } else {
                let errorDescription = error?.localizedDescription
                print("error: \(errorDescription)")
                // Display error
            }

        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        cell.messageLabel.text = messages[indexPath.row]["text"] as! String?
        return cell
    }
    
    func onTimer() {
        let query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) in
            if error == nil {
                print("Successfully retrieved \(messages!.count) messages.")
                let messagesArray = messages!
                self.messages = messagesArray
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error?.localizedDescription)")
            }

        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
