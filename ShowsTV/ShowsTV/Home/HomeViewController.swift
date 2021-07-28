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
    
    // MARK: outlets
    
    @IBOutlet private weak var showTitleLabel: UILabel!
    @IBOutlet private weak var showsTableView: UITableView!
    
    
    // MARK: functions, API fetching
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let authInfo = authInfo else {return}
        
        SVProgressHUD.show()
        setupTableView()
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
        showsTableView.reloadData()
    }
    func setUserResponseAndAuthInfo(user:User, authInfo:AuthInfo){
        self.user = user
        self.authInfo = authInfo
    }
}

extension HomeViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showsTableView.deselectRow(at: indexPath, animated: true)
        guard let shows = shows else {return}
        guard let user = user else {return}
        guard let authInfo = authInfo else {return}
        let show = shows.shows[indexPath.row]
        print("Selected Item: \(show)")
        navigateToDetails(user: user, authInfo: authInfo, show: show)
    }
}


extension HomeViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        // Default implementation - if not implemented would return 1 as well
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          guard let shows = shows else {return 0}
          return shows.shows.count
      }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: showsTableViewCell.self),
            for: indexPath
        ) as! showsTableViewCell

        cell.configure(with: shows!.shows[indexPath.row])

        return cell
    }
}

// MARK: - Private

private extension HomeViewController {

    func setupTableView() {
        showsTableView.estimatedRowHeight = 110
        showsTableView.rowHeight = UITableView.automaticDimension

        showsTableView.tableFooterView = UIView()

        showsTableView.delegate = self
        showsTableView.dataSource = self
    }
}

// MARK: - Navigate to Details
private extension HomeViewController {
    func navigateToDetails(user:User, authInfo:AuthInfo, show:Show) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)

        guard let detailsViewController =         storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {return}
        detailsViewController.setUserResponseAndAuthInfo(user: user, authInfo: authInfo)
        detailsViewController.setShow(show: show)
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
