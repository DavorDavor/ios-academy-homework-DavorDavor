//
//  LoginViewController.swift
//  ShowsTV
//
//  Created by Infinum  on 14.07.2021..
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private var numberOfClicks = 0
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
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
}

