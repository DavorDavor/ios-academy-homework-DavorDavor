//
//  HomeViewController.swift
//  ShowsTV
//
//  Created by Infinum  on 20.07.2021..
//

import Foundation
import UIKit


class HomeViewController : UIViewController {
    
    // MARK: properties
    var user:User?
    var authInfo:AuthInfo?
    @IBOutlet private weak var blabel:UILabel!
    @IBOutlet private weak var buttonText: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUserResponseAndAuthInfo(user:User, authInfo:AuthInfo){
        self.user = user
        self.authInfo = authInfo
    }
}
