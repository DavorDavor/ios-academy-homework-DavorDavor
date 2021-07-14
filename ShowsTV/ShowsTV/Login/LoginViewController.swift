//
//  LoginViewController.swift
//  ShowsTV
//
//  Created by Infinum  on 14.07.2021..
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    
    var taps = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("test")
    }
    @IBAction func IBAction(_ sender: Any) {
        taps += 1
        IBOutlet.text = String(taps)
        print("Button disturbed")
        
        if(!activityIndicator.isAnimating){
            activityIndicator.startAnimating()
        } else{
            activityIndicator.stopAnimating()
        }
    }
    
    
    @IBOutlet weak var IBOutlet: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}

