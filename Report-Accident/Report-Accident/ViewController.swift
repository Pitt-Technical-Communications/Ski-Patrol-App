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
    
}
