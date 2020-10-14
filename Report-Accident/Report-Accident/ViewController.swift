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

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
