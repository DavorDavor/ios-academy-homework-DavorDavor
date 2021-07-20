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
    @IBOutlet private weak var passwordTextField: UITextField!
    
    @IBOutlet weak var rememberMeButton: UIButton!
    
    // MARK: - Properties
    private var rememberMe = false
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: Actions
    
    @IBAction private func showPassword(_ sender: Any) {
            passwordTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction func rememberMe(_ sender: Any) {
        if rememberMe {
            rememberMeButton.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
            rememberMe = false
        } else {
            rememberMeButton.setBackgroundImage(UIImage(named: "checked"), for: .normal)
            rememberMe = true
        }
    }
    
    @IBAction func loginOnClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        let homeViewController = storyboard.instantiateViewController(withIdentifier:
        "HomeViewController")
        
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    @IBAction func registerOnClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        let homeViewController = storyboard.instantiateViewController(withIdentifier:
        "HomeViewController")
        
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}

