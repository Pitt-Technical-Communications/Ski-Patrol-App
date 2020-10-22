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
        if let phoneURL = URL(string: "tel://\(4123430967)")
        {
            UIApplication.shared.open(phoneURL)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // Redirect to trail map button
    @IBAction func ToTrailMap(_ sender: Any)
    {
        if let mapURL = URL(string: "https://www.7springs.com/mountain/slope-trail-guide/")
        {
            UIApplication.shared.open(mapURL)
        }
    }
    
}

