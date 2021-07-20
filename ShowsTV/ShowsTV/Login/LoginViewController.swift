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
    @IBOutlet private weak var Password: UITextField!
    @IBOutlet private weak var RememberMe: UIButton!
    
    // MARK: - Properties
    private var rememberMe = false
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: Actions
    
    @IBAction private func showPassword(_ sender: Any) {
        if Password.isSecureTextEntry {
            Password.isSecureTextEntry = false
        } else {
            Password.isSecureTextEntry = true
        }
    }
    
    @IBAction func rememberMe(_ sender: Any) {
        if rememberMe {
            RememberMe.setBackgroundImage(UIImage(named: "unchecked"), for: UIControl.State.normal)
            rememberMe = false
        } else {
            RememberMe.setBackgroundImage(UIImage(named: "checked"), for: UIControl.State.normal)
            rememberMe = true
        }
    }
    
}

