//
//  RegisterViewController.swift
//  Personal Project
//
//  Created by Noah Eaton on 11/17/18.
//  Copyright © 2018 Noah Eaton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Register"

    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                
                print(error!)
            }
            else {
                
                
                print("Registration Successful!")
            }
            
            
        }
        
    }
    

}
