//
//  LoginViewController.swift
//  parse-chat
//
//  Created by William Huang on 2/23/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 5

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let email = emailField.text
        let password = passwordField.text
        PFUser.logInWithUsername(inBackground: email!, password: password!) { (user: PFUser?, error:Error?) in
            if let error = error {
                let errorDescription = error.localizedDescription
                print(errorDescription)
                let alert = UIAlertController(title: "Error", message: errorDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                print("logged in")
                self.performSegue(withIdentifier: "MessagesSegue", sender: self)
            }
        }
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
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
