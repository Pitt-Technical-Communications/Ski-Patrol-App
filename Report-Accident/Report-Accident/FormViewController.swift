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
    @IBOutlet weak var LocationInfo: UITextField!
    @IBOutlet weak var BloodScene: UISwitch!
    @IBOutlet weak var NotMovingSwitch: UISwitch!
    @IBOutlet weak var MultipleVictimsSwitch: UISwitch!
    @IBOutlet weak var submitButton: UIButton!
    
    // Checkers for valid input
    var isValidText = false
    
    // Picker Items
    var slopes:[String] = [String]()
    var selectedSlope = -1
    
    // Socket item to communicate with server
    var connectionTest = SocketDataManager()
    var connection = SocketDataManager()
   
    override func viewDidLoad()
    {
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
        
        super.viewDidLoad()
        // Set data source and delegate
        slopePicker.dataSource = self
        slopePicker.delegate = self
        slopes = ["--","Other (Explain Below)", "Alpine Meadows", "Avalanche", "Beginner Area", "Blitzen Chairline", "Boomerang", "Cortina Trail", "Deer Pass Trail", "Fawn Lane", "Giant Boulder", "Giant Steps", "Goosebumps", "Great Western", "Gunnar", "Gunnar Chairline", "Little Boulder", "Little North Face", "Lost Boy", "Lost Girl", "North Face", "Phillip's Run", "Stowe", "Stowe Beginner Bowl", "Stowe Trail", "Tyrol",  "Village Trail", "Wagner", "Yodeler", "Yodeler Bypass"]
        
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // Check if server is connected if user starts editing the form
        let m_rec = connectionTest.getMessageReceived()
        if m_rec == ""
        {
            // Display Alert and navigate back to main screen
            let sucessAlert = UIAlertController(title: "Error", message: "Could not connect to server. Please contact server administrator. If this is an emergency, call Ski Patrol using number on Home Page", preferredStyle: .alert)
            
            sucessAlert.addAction(UIAlertAction(title:"Return to Main Screen", style: .default, handler: returnToHome))
            
            self.present(sucessAlert, animated: true)
        }
        
       selectedSlope = row
        
        if(selectedSlope < 1)
        {
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
        }
        if isValidText && (selectedSlope > 0)
        {
            submitButton.isEnabled = true
            submitButton.alpha = 1
        }
    }
    
    // Check that the server is connected when user starts editing text field
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        // Check if server is connected if user starts editing the form
        let m_rec = connectionTest.getMessageReceived()
        if m_rec == ""
        {
            // Display Alert and navigate back to main screen
            let sucessAlert = UIAlertController(title: "Error", message: "Could not connect to server. Please contact server administrator. If this is an emergency, call Ski Patrol using number on Home Page", preferredStyle: .alert)
            
            sucessAlert.addAction(UIAlertAction(title:"Return to Main Screen", style: .default, handler: returnToHome))
            
            self.present(sucessAlert, animated: true)
        }
    }
    // Delegate for UITextFeild
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if LocationSlope.text == ""
        {
            isValidText = false
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
        }
        else if LocationSlope.text == " " || LocationSlope.text == "  "
        {
            isValidText = false
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
        }
        else if LocationSlope.text == "Example: Top, Skier's Right"
        {
            isValidText = false
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
        }
        else
        {
            isValidText = true
        }
        
        // Enable submit button if requried fields are filld out
        if isValidText && (selectedSlope > 0)
        {
            submitButton.isEnabled = true
            submitButton.alpha = 1
        }
    }
    
    /*
     * Submit Button
     */
    // Form Submited action button click
    @IBAction func SubmitFormButton(_ sender: Any)
    {
        // Chooe which message to display based on earlier probe to server
        let m_rec = connectionTest.getMessageReceived()
        if m_rec != ""
        {
            var m_tosend = "3 "
            
            // Construct message to server
            if(selectedSlope < 10)
            {
                m_tosend.append("0")    // Add leading 0 if the index <10
            }
            m_tosend.append(String(selectedSlope))
            m_tosend.append(" ")
            if BloodScene.isOn
            {
                m_tosend.append("1 ")
            }
            else
            {
                m_tosend.append("0 ")
            }
            if NotMovingSwitch.isOn
            {
                m_tosend.append("1 ")
            }
            else
            {
                m_tosend.append("0 ")
            }
            if MultipleVictimsSwitch.isOn
            {
                m_tosend.append("1 ")
            }
            else
            {
                m_tosend.append("0 ")
            }
            m_tosend.append(LocationInfo.text ?? "None...")
            
            // Send server constructed message
            connection.send(message: m_tosend)
            
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


