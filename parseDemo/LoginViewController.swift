//
//  LoginViewController.swift
//  parseDemo
//
//  Created by LING HAO on 4/12/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet var loginText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    @IBAction func onLoginButton(_ sender: UIButton) {
        //        var user = PFUser()
        //if let username = loginText.text, let password = passwordText.text {
            let username = "Ling"
            let password = "Ling"
            PFUser.logInWithUsername(inBackground: username, password: password, block: { (user: PFUser?, error: Error?) in
                if user != nil {
                    print(user!)
                    self.performSegue(withIdentifier: "OpenChat", sender: nil)
                }
                else {
                    print("Login Failed!")
                    let alertController = UIAlertController(title: "Login Failed", message: "Invalid username or password", preferredStyle: .alert)
                    let OKaction = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
                        print("OK clicked in Login Alert")
                    })
                    alertController.addAction(OKaction)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        //}
    }
    
    @IBAction func onSignUpButton(_ sender: UIButton) {
        let user = PFUser()
        if let username = loginText.text, let password = passwordText.text {
            user.username = "Ling"
            //            user.email = username
            //            user.password = password
            user.email = "Ling@ling.com"
            user.password = "Ling"
            
            
            
            user.signUpInBackground(block: { (succeeded: Bool, error: Error?) in
                if let error = error {
                    print(error)
                }
                else {
                    print("Signup successful")
                }
            })
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
