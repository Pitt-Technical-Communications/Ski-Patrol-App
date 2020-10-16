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
        /*
         * After Load Inititializations
         */
        // Hides navigation bar on home page
        self.navigationController?.isNavigationBarHidden = true;
        
        // Sets navigation bar color
        //self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 254/255, green: 80/255, blue: 74/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "redAccent")

        
        // Sets navigation bar title color and font
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 36.0)]
        
        // Sets font size for back button
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 20.0)], for: UIControl.State.normal)

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

