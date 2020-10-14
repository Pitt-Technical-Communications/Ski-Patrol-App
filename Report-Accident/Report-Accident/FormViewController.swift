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
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set data source and delegate
        slopePicker.dataSource = self
        slopePicker.delegate = self
        slopes = ["Other (Explain Below)", "Alpine Meadows", "Avalanche", "Beginner Area", "Blitzen Chairline", "Boomerang", "Cortina Trail", "Deer Pass Trail", "Fawn Lane", "Giant Boulder", "Giant Steps", "Goosebumps", "Great Western", "Gunnar", "Gunnar Chairline", "Little Boulder", "Little North Face", "Lost Boy", "Lost Girl", "North Face", "Phillip's Run", "Stowe", "Stowe Beginner Bowl", "Stowe Trail", "Tyrol",  "Village Trail", "Wagner", "Yodeler", "Yodeler Bypass"]
        
        LocationSlope.delegate = self
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
        
        // Display Alert and navigate back to main screen
        let sucessAlert = UIAlertController(title: "Form Submitted", message: "Your accident report form was sucessfuly submited.", preferredStyle: .alert)
        
        sucessAlert.addAction(UIAlertAction(title:"Return to Main Screen", style: .default, handler: nil))
        
        self.present(sucessAlert, animated: true)
    }
    
    @IBOutlet weak var LocationSlope: UITextField!
    
    func textFieldShouldReturn(_ textFeild: UITextField) -> Bool
    {
        textFeild.resignFirstResponder()
        return true
    }
}
