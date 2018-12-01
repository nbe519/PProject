//
//  LoginViewController.swift
//  Personal Project
//
//  Created by Noah Eaton on 11/17/18.
//  Copyright © 2018 Noah Eaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Login"
        //self.navigationItem.setHidesBackButton(true, animated:true);

    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                
                print(error!)
                
            }
            else {
                
                print("Log-in was successful")
                self.performSegue(withIdentifier: "success", sender: self)
                
            }
        }
        
    }
    

}
