//
//  LoginViewController.swift
//  ShowsTV
//
//  Created by Infinum  on 14.07.2021..
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    
    @IBAction private func buttonClick(_ sender: Any) {
        numberOfClicks += 1
        titleLabel.text = String(numberOfClicks)
        print("Button disturbed")
        
        if activityIndicator.isAnimating{
            activityIndicator.stopAnimating()
        } else{
            activityIndicator.startAnimating()
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var numberOfClicks = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

