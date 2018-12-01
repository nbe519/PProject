//
//  ServiceViewController.swift
//  Personal Project
//
//  Created by Noah Eaton on 11/21/18.
//  Copyright © 2018 Noah Eaton. All rights reserved.
//

import UIKit
import Firebase

class ServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    //Instance variables
    var eventArray : [Service] = [Service]() //set the messesges 
    
    @IBOutlet weak var eventTableView: UITableView!

    
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        //set the tableViews delegate as myself
        eventTableView.delegate = self
        eventTableView.dataSource = self
        
        
        
        
        //Register the .xib file
        eventTableView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellReuseIdentifier: "customServiceCell")
        
        configureTableView()
        
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customServiceCell", for: indexPath) as! CustomEventCell
        
        
        //called for every cell in the table view
        //messageBody becomes messageBody of the cell
        cell.eventName.text = eventArray[indexPath.row].serviceName
        cell.eventDes.text = eventArray[indexPath.row].serviceDescription
//        cell.senderUsername.text = messageArray[indexPath.row].sender
//        cell.avatarImageView.image = UIImage(named: "egg")
        
        
        return cell
    }
    
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField =  UITextField()
        
        //create an alert to create a new reminder
        let alert = UIAlertController(title: "New Event", message: "", preferredStyle: .alert)
        
        //give it an action
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newEvent = Service()
            newEvent.serviceDescription = textField.text!
            
            
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        //give the alert the textField
        alert.addTextField { (textfield) in
            textfield.placeholder = "Description"
            textField = textfield
            
        }
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true,  completion: nil)
    }
    
    
    func configureTableView() {
        
        //makes cell as large as it needs to be, based on the text inside. There are contraints set to do this
        eventTableView.rowHeight = UITableView.automaticDimension
        eventTableView.estimatedRowHeight = 300
        
    }
    
    func retriveEvent() {
        let eventDB = Database.database().reference().child("Events")
        //save message as a dictionary
        //sender is the user that is signed in
        let messageDictionary = ["MessageBody" : .text]
        
        //creates custom ID so messages can be saved under their respective identifier
        //Save the message dictionary inside message database under an automatically generated identifier
        messageDB.childByAutoId().setValue(messageDictionary) {//closure
            (error, reference) in //reference is the reference of data saved
            
            if error != nil {
                print(error!)
            }
                
            else {
                print("Message saved successfully!")
                
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
            
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        //log out the current user using Firebase, this is a throws block
        do {
            //this is the line that potentially throws an error, but try it
            try Auth.auth().signOut()
            //bring user back to register/login screen
            navigationController?.popToRootViewController(animated: true)
        }
            //if any errors
        catch{
            print("errors, there was a problem sigining out.")
        }
        
    }
    
}
