
//
//  LoginViewController.swift
//  ParseStuff
//
//  Created by michelle johnson on 9/9/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//
import Parse
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet var loginView: UIView!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
       override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func signUpTouch(sender: AnyObject) {
        println("here")
        signUp()
    }

    
    @IBAction func signInTouch(sender: AnyObject) {
        
        signIn()
    }

    
    func signUp() {
        if emailTextField.text != nil && passwordTextField.text != nil {
            var user = PFUser()
            user.username = emailTextField.text
            user.email = emailTextField.text
            user.password = passwordTextField.text
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo?["error"] as? NSString
                    // Show the errorString somewhere and let the user try again.
                    println(errorString)
                } else {
                    // Hooray! Let them use the app now.
                    println("You've logged in!")
                    self.performSegueWithIdentifier("successfulLoginSegue", sender: self)
                }
            }
        }
    }
    
    func signIn() {
        var username = emailTextField.text
        var password = passwordTextField.text
        PFUser.logInWithUsernameInBackground(username, password: password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                println("yay you're logged in")
                self.performSegueWithIdentifier("successfulLoginSegue", sender: self)
            } else {
                // The login failed. Check error to see why.
                println("couldn't log in")
            }
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
