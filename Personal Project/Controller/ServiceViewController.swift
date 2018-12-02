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
    var textField =  UITextField()
    
    @IBOutlet weak var eventTableView: UITableView!

    
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Remove the backbutton, this is replaced with an "+" for adding events
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        //set the tableViews delegate as myself
        eventTableView.delegate = self
        eventTableView.dataSource = self
        
        
        //Register the .xib file
        eventTableView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellReuseIdentifier: "customServiceCell")
        
        //configureTableView()
        retriveEvent()
        
        //Remove the lines from the table cells
        eventTableView.separatorStyle = .none
    }
    

    //Dictate the # of rows in the tableView; it will be the number of items in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return eventArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create a reusable cell that is made out of the CustonEventCell guidlines
        let cell = tableView.dequeueReusableCell(withIdentifier: "customServiceCell", for: indexPath) as! CustomEventCell
        
        cell.eventName.text = eventArray[indexPath.row].serviceName
        cell.eventDes.text = eventArray[indexPath.row].serviceDescription

        
        
        return cell
    }
    
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //create an alert to create a new reminder
        let alert = UIAlertController(title: "New Event", message: "", preferredStyle: .alert)
        
        //give it an action
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let eventDB = Database.database().reference().child("Events")
            //save message as a dictionary
            //sender is the user that is signed in
            print(self.textField.text!)
            let eventDictionary = ["MessageBody" : self.textField.text!]
            
            //creates custom ID so messages can be saved under their respective identifier
            //Save the message dictionary inside message database under an automatically generated identifier
            eventDB.childByAutoId().setValue(eventDictionary) {
                (error, reference) in //reference is the reference of data saved
                
                if error != nil {
                    print(error!)
                }
                    
                else {
                    print("Message saved successfully!")
                    self.retriveEvent()
                }
                
            }

            
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        //give the alert the textField
        alert.addTextField { (textfield) in
            textfield.placeholder = "Description"
            self.textField = textfield
            
        }
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true,  completion: nil)
    }
    
    
//    func configureTableView() {
//
//        //makes cell as large as it needs to be, based on the text inside. There are contraints set to do this
//        eventTableView.rowHeight = UITableView.automaticDimension
//        eventTableView.estimatedRowHeight = 300
//
//    }
    
    func saveEvent() {
//        let eventDB = Database.database().reference().child("Events")
//        //save message as a dictionary
//        //sender is the user that is signed in
//        let eventDictionary = ["MessageBody" : self.textField.text!]
//
//        //creates custom ID so messages can be saved under their respective identifier
//        //Save the message dictionary inside message database under an automatically generated identifier
//        eventDB.childByAutoId().setValue(eventDictionary) {
//            (error, reference) in //reference is the reference of data saved
//
//            if error != nil {
//                print(error!)
//            }
//
//            else {
//                print("Message saved successfully!")
//                self.retriveEvent()
//            }
//
//        }
    }
    
    func retriveEvent() {
        let eventDB = Database.database().reference().child("Events") //reference to childBaseDataBase named messages
        
        //obeserving for the event, childAdded, not constantly retriving, only when new event is added to database
        eventDB.observe(.childAdded) { (snapshot) in
            
            //treat this data as a dictionary
            let snapshotValue = snapshot.value as! Dictionary<String, String>//<> how to represent datatype
            print(snapshotValue)
            //should pull out value as optional string, to make real string, unwrapping it
            let text = snapshotValue["MessageBody"]!
            
            //using message class to structure the message class to pull them out at a later stage
            let event = Service()
            event.serviceDescription = text
            //append message object into the array
            self.eventArray.append(event)
            
           // self.configureTableView()
            
            //every time we add new data to database, this method will be triggered and we will need to reload the tableView with the new data
            self.eventTableView.reloadData()
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
