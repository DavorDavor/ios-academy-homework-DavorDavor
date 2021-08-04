//
//  LoginViewController.swift
//  ShowsTV
//
//  Created by Infinum  on 14.07.2021..
//

import UIKit
import SVProgressHUD
import Alamofire

class LoginViewController : UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var rememberMeButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    // MARK: - Properties
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: Actions
    
    @IBAction private func showPassword(_ sender: Any) {
            passwordTextField.isSecureTextEntry.toggle()
    }
    
    // Toggles 'Remember me' checkbox
    @IBAction private func rememberMe(_ sender: Any) {
        rememberMeButton.isSelected.toggle()
    }
    
    // triggers login API call, pushes to Home on success
    @IBAction private func loginOnClick(_ sender: UIButton) {
        
        // Check if fields empty
        guard
            let username = emailTextField.text,
            let password = passwordTextField.text,
            !username.isEmpty,
            !password.isEmpty
        else {
            
            return
        }
        
        sender.pulse()
        
        loginUserWith(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    // triggers register and login API call, pushes to Home on success
    @IBAction private func registerOnClick(_ sender: UIButton) {
        
        sender.pulse()
        
        // Check if fields empty
        guard
            let username = emailTextField.text,
            let password = passwordTextField.text,
            !username.isEmpty,
            !password.isEmpty
        else {
            return
        }
        registerUserWith(email: emailTextField.text!, password: passwordTextField.text!)
    }
}

// MARK: login via alamofire

private extension LoginViewController {
    
    func loginUserWith(email: String, password: String) {
        SVProgressHUD.show()

        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]

        AF
            .request(
                "https://tv-shows.infinum.academy/users/sign_in",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { [weak self] dataResponse in
                switch dataResponse.result {
                case .success(let userResponse):
                    guard let self = self else { return }
                    let headers = dataResponse.response?.headers.dictionary ?? [:]
                    self.handleSuccesfulLogin(for: userResponse.user, headers: headers)
                case .failure(let error):
                    guard let self = self else { return }
                    let alert = UIAlertController(title: "Login failed.", message: "Please check your email and/or password .", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    SVProgressHUD.showError(withStatus: "Failure")
                    print("Error parsing data: \(error)")
                }
            }
    }
    
    func handleSuccesfulLogin(for user: User, headers: [String: String]) {
        guard let authInfo = try? AuthInfo(headers: headers) else {
            SVProgressHUD.showError(withStatus: "Missing headers")
            return
        }
        SVProgressHUD.showSuccess(withStatus: "Success")
        self.navigateToHome(user: user, authInfo: authInfo)
    }
}


// MARK: register via alamofire

private extension LoginViewController {
    
    func registerUserWith(email: String, password: String) {
        SVProgressHUD.show()

        let parameters: [String: String] = [
            "email": email,
            "password": password,
            "password_confirmation": password
        ]

        AF
            .request(
                "https://tv-shows.infinum.academy/users",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { [weak self] dataResponse in
                switch dataResponse.result {
                case .success(let userResponse):
                    guard let self = self else { return }
                    let headers = dataResponse.response?.headers.dictionary ?? [:]
                    self.handleSuccesfulLogin(for: userResponse.user, headers: headers)
                case .failure(let error):
                    guard let self = self else { return }
                    let alert = UIAlertController(title: "Registration failed.", message: "Email invalid or already taken.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    SVProgressHUD.showError(withStatus: "Failure")
                    print("Error parsing data: \(error)")
                }
            }
    }
}

// MARK: function to navigate to HomeViewController
private extension LoginViewController {
    func navigateToHome(user:User, authInfo:AuthInfo) {
        
        if rememberMeButton.isSelected {
            saveToUserDefaults(user: user, authInfo: authInfo)
        }
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)

        guard let homeViewController =         storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {return}
        homeViewController.setUserResponseAndAuthInfo(user: user, authInfo: authInfo)
        
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}

// MARK: function to save user defaults if RememberMe

private extension LoginViewController {
    func saveToUserDefaults (user: User, authInfo: AuthInfo){
        // Save
        let encoder = PropertyListEncoder()
        if
            let encodedUser = try? encoder.encode(user),
            let encodedAuthInfo = try? encoder.encode(authInfo) {
            UserDefaults.standard.set(encodedUser, forKey: Constants.UserDefaults.userKey)
            UserDefaults.standard.set(encodedAuthInfo, forKey: Constants.UserDefaults.authInfoKey)
        }
        
    }
}
