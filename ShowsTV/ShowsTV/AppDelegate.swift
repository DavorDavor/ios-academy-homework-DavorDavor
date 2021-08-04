//
//  AppDelegate.swift
//  ShowsTV
//
//  Created by Infinum  on 14.07.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       // Create navigation controller in which we will embedd our starting view controller
        let navigationController = UINavigationController()

        // Restore user and authInfo
        let decoder = PropertyListDecoder()
        if
            let userData = UserDefaults.standard.data(forKey: Constants.UserDefaults.userKey),
            let authInfoData = UserDefaults.standard.data(forKey: Constants.UserDefaults.authInfoKey),
            let decodedUser = try? decoder.decode(User.self, from: userData),
            let decodedAuthInfo = try? decoder.decode(AuthInfo.self, from: authInfoData)
        {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            
            guard let homeViewController =
                    storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {return true}
            homeViewController.setUserResponseAndAuthInfo(user: decodedUser, authInfo: decodedAuthInfo)
            
            navigationController.pushViewController(homeViewController, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            guard let loginViewController =
                    storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {return true}
            navigationController.viewControllers = [loginViewController]
        }
        
       
       // Set the navigation controller as starting point of the app
        guard
            let window = window
        else { return true }
       window.rootViewController = navigationController

        return true
    }



}

