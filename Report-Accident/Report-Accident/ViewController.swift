//
//  ViewController.swift
//  Report-Accident
//
//  Created by Andrew Toader on 10.13.20.
//

import UIKit

class ViewController: UIViewController {
    
    // Action When Call Ski Patrol Button is Pressed
    @IBAction func CallPhone(_ sender: UIButton)
    {
        if let phoneURL = URL(string: "tel://\(1234567890)")
        {
            UIApplication.shared.open(phoneURL)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        /*
         * After Load Inititializations
         */
        
    }
    
    class FormVC: UIViewController
    {
        // Set Picker View as output
        @IBOutlet weak var slopePicker: UIPickerView!
        
        // Picker Items
        var slopes = ["Other", "Boomerang", "Avalanche", "Tyrol"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set data source and delegate
            slopePicker.dataSource = self
            slopePicker.delegate = self
        }
    }
    
}

extension ViewController.FormVC: UIPickerViewDataSource, UIPickerViewDelegate
{
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
