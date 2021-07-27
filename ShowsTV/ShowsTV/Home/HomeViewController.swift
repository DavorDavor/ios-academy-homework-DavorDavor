//
//  HomeViewController.swift
//  ShowsTV
//
//  Created by Infinum  on 20.07.2021..
//

import Foundation
import SVProgressHUD
import Alamofire
import UIKit


class HomeViewController : UIViewController {
    
    // MARK: properties
    var user:User?
    var authInfo:AuthInfo?
    var shows:ShowsResponse?
    
    @IBOutlet private weak var showTitleLabel: UILabel!
    @IBOutlet private weak var showsTableView: UITableView!
    @IBOutlet private weak var showsTableViewCell: UITableViewCell!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let authInfo = authInfo else {return}
        
        SVProgressHUD.show()
        
     AF .request(
             "https://tv-shows.infinum.academy/shows",
             method: .get,
             parameters: ["page": "1", "items": "100"], // pagination arguments
             headers: HTTPHeaders(authInfo.headers)
         )
         .validate()
         .responseDecodable(of: ShowsResponse.self) { [weak self] dataResponse in
            switch dataResponse.result {
            case .success(let showsResponse):
                guard let self = self else {return}
                self.setShows(shows: showsResponse)
                SVProgressHUD.showSuccess(withStatus: "Success")
            case .failure(let error):
                print("Error parsing data: \(error)")
                SVProgressHUD.showError(withStatus: "Failure")
            }
         }
    }
    
  
    func setShows(shows:ShowsResponse){
        self.shows = shows
        
    }
    func setUserResponseAndAuthInfo(user:User, authInfo:AuthInfo){
        self.user = user
        self.authInfo = authInfo
    }
}
