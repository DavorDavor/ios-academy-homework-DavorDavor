//
//  ProfileDetailsViewController.swift
//  ShowsTV
//
//  Created by Infinum  on 01.08.2021..
//

import UIKit

let NotificationLogoutInit = Notification.Name(rawValue: "NotificationLogoutInit")

class ProfileDetailsViewController : UIViewController {


    // MARK: properties
    var user:User?
    var authInfo:AuthInfo?


    // MARK: outlets



    // MARK: functions, API fetching
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Account"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didSelectClose)
          )
    }


    @objc private func didSelectClose() {
        dismiss(animated: true, completion: nil)
    }

    // hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }



    func setUserResponseAndAuthInfo(user:User, authInfo:AuthInfo) {
        self.user = user
        self.authInfo = authInfo
    }

    @IBAction private func browseImageOnClick(_ sender: Any) {
    }
    
    @IBAction private func logoutOnClick(_ sender: Any) {
        dismiss(animated: true, completion: {
            let notification = Notification(
                name: NotificationLogoutInit,
                object: nil
            )
            
            // clear auth info to be added
            
            NotificationCenter.default.post(notification)
        })
    }
}
