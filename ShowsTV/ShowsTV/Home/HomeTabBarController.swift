//
//  HomeTabBarController.swift
//  ShowsTV
//
//  Created by Infinum  on 03.08.2021..
//
import UIKit
import Foundation

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: properties
    var user: User?
    var authInfo: AuthInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard
            let user = user,
            let authInfo = authInfo
        else {return}
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)

        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        
        guard
            let homeViewController = homeViewController
        else {return}
        
        homeViewController.setUserResponseAndAuthInfo(user: user, authInfo: authInfo)
        
        let showsItem = UITabBarItem(title: "Shows", image: UIImage(named: "someImage.png"), selectedImage: UIImage(named: "otherImage.png"))
        item1.tabBarItem = icon1
        let controllers = [item1]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
    
    
    func setUserResponseAndAuthInfo(user:User, authInfo:AuthInfo){
        self.user = user
        self.authInfo = authInfo
    }
}
