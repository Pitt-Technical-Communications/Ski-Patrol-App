//
//  ScrollViewController.swift
//  Report-Accident
//
//  Created by Tyler Comisky on 10/13/20.
//

import UIKit

class FormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // Set Picker View as output
    @IBOutlet weak var slopePicker: UIPickerView!
    
    // Picker Items
    var slopes:[String] = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set data source and delegate
        slopePicker.dataSource = self
        slopePicker.delegate = self
        slopes = ["Other", "Boomerang", "Avalanche", "Tyrol"]
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
}


