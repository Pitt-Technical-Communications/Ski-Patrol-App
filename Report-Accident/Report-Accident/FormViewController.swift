//
//  ScrollViewController.swift
//  Report-Accident
//
//  Created by Tyler Comisky on 10/13/20.
//

import UIKit

class FormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    /*
     * Picker View
     */
    
    // Set Picker View as output
    @IBOutlet weak var slopePicker: UIPickerView!
    
    // Picker Items
    var slopes:[String] = [String]()
    
    // Socket item to communicate with server
    var connectionTest = SocketDataManager()
    var connection = SocketDataManager()
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Set data source and delegate
        slopePicker.dataSource = self
        slopePicker.delegate = self
        slopes = ["Other (Explain Below)", "Alpine Meadows", "Avalanche", "Beginner Area", "Blitzen Chairline", "Boomerang", "Cortina Trail", "Deer Pass Trail", "Fawn Lane", "Giant Boulder", "Giant Steps", "Goosebumps", "Great Western", "Gunnar", "Gunnar Chairline", "Little Boulder", "Little North Face", "Lost Boy", "Lost Girl", "North Face", "Phillip's Run", "Stowe", "Stowe Beginner Bowl", "Stowe Trail", "Tyrol",  "Village Trail", "Wagner", "Yodeler", "Yodeler Bypass"]
        
        LocationSlope.delegate = self
        
        let server_info = DataSocket(ip: "3.23.104.34", port_in: 1235)
        connectionTest.connectWith(socket: server_info)
        connection.connectWith(socket: server_info)
        
        connectionTest.send(message: "2 Probe")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return slopes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return slopes[row]
    }
    
    /*
     * Submit Button
     */
    // Form Submited action button click
    @IBAction func SubmitFormButton(_ sender: Any)
    {
        // Put Server Code here
        connection.send(message: "3 Accident Report")
        
        let m_rec = connectionTest.getMessageReceived()
        
        if m_rec != ""
        {
            // Display Alert and navigate back to main screen
            let sucessAlert = UIAlertController(title: "Form Submitted", message: "Your accident report form was sucessfuly submited.", preferredStyle: .alert)
            
            sucessAlert.addAction(UIAlertAction(title:"Return to Main Screen", style: .default, handler: returnToHome))
            
            self.present(sucessAlert, animated: true)
            
            connection.setMessageReceived(message: "")
        }
        else
        {
            // Display Alert and navigate back to main screen
            let sucessAlert = UIAlertController(title: "Error", message: "Could not connect to server. Please contact server administrator. If this is an emergency, call Ski Patrol using number on Home Page", preferredStyle: .alert)
            
            sucessAlert.addAction(UIAlertAction(title:"Return to Main Screen", style: .default, handler: returnToHome))
            
            self.present(sucessAlert, animated: true)
        }
        
        connection.disconnect()
    }
    
    func returnToHome(alert: UIAlertAction!) {
        performSegue(withIdentifier: "exitForm", sender: nil)
    }
    
    /*
     * Slope Location Text Box
     */
    @IBOutlet weak var LocationSlope: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
 }


