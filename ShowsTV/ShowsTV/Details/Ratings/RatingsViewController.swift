//
//  RatingsViewController.swift
//  ShowsTV
//
//  Created by Infinum  on 28.07.2021..
//

import Foundation
import SVProgressHUD
import Alamofire
import UIKit

class RatingsViewController : UIViewController {
    
    
    // MARK: properties
    var user:User?
    var authInfo:AuthInfo?
    var show:Show?
    private var review:Review?
    
    // MARK: outlets
    
    @IBOutlet private weak var detailsTableView: UITableView!
    @IBOutlet private weak var detailsTitleLabel: UILabel!
    @IBOutlet private weak var detailsDescriptionLabel: UITableView!
    @IBOutlet private weak var detailsRating: UITableView!
    
    
    // MARK: functions, API fetching
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Write a Review"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didSelectClose)
          )
        
    }
    
    
    @objc private func didSelectClose() {
        // programatically dismiss view controller
        dismiss(animated: true, completion: nil) // push <-> pop; present <->dismiss
    }
    
    // hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    
    func setUserResponseAndAuthInfoAndShow(user:User, authInfo:AuthInfo, show:Show) {
        self.user = user
        self.authInfo = authInfo
        self.show = show
    }
    
    @IBAction private func writeAReviewOnClick(_ sender: Any) {
        
    }
}
