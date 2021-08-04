//
//  TopRatedViewController.swift
//  ShowsTV
//
//  Created by Infinum  on 03.08.2021..
//

import Foundation
import UIKit

class TopRatedViewController: UIViewController {
    
    // MARK: properties
    var user: User?
    var authInfo: AuthInfo?
    var shows: [Show] = []
    var notificationToken: NSObjectProtocol?
    var profileDetailsViewController: ProfileDetailsViewController?
    
    // MARK: outlets
    
    @IBOutlet private weak var showsTableView: UITableView!
    
    
    // MARK: functions, API fetching
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        
        // Add navigation item
            let profileDetailsItem = UIBarButtonItem(
              image: UIImage(named: "ic-profile"),
              style: .plain,
     
     
            target: self,
              action: #selector(profileDetailsActionHandler)
            )
            profileDetailsItem.tintColor = UIColor.purple
            navigationItem.rightBarButtonItem = profileDetailsItem
        
            // Notification for logout
            notificationToken = NotificationCenter
                .default
                .addObserver(
                    forName: NotificationLogoutInit,
                    object: nil,
                    queue: nil,
                    using: { [weak self] notification in
                        self?.logoutOnNotification()
                    }
                )
        }

        deinit {
            NotificationCenter.default.removeObserver(notificationToken!)
        }
    
    
    @objc
    private func profileDetailsActionHandler() {
        guard
            let user = user,
            let authInfo = authInfo
        else {return}
        
        navigateToProfileDetails(user: user, authInfo: authInfo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    func setShows(shows:ShowsResponse){
        shows.shows.forEach { show in
            if show.averageRating >= 4.0 {
                self.shows.append(show)
            }
        }
        showsTableView.reloadData()
    }
    
    func setUserResponseAndAuthInfo(user:User, authInfo:AuthInfo){
        self.user = user
        self.authInfo = authInfo
    }
    
    @IBAction private func navigateToProfileOnClick(_ sender: Any) {
        guard
            let user = user,
            let authInfo = authInfo
        else {return}
        navigateToProfileDetails(user: user, authInfo: authInfo)
    }

}

extension TopRatedViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showsTableView.deselectRow(at: indexPath, animated: true)
        guard
            let user = user,
            let authInfo = authInfo
        else {return}
        
        navigateToDetails(user: user, authInfo: authInfo, show: shows[indexPath.row])
    }
}

extension TopRatedViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        // Default implementation - if not implemented would return 1 as well
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return shows.count
      }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: showsTableViewCell.self),
            for: indexPath
        ) as! showsTableViewCell

        cell.configure(with: shows[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.5,
            delay: 0.1 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
}

private extension TopRatedViewController {

    func setupTableView() {
        showsTableView.estimatedRowHeight = 110
        showsTableView.rowHeight = UITableView.automaticDimension

        showsTableView.tableFooterView = UIView()

        showsTableView.delegate = self
        showsTableView.dataSource = self
    }
}

// MARK: - Navigate to Details
private extension TopRatedViewController {
    func navigateToDetails(user: User, authInfo: AuthInfo, show: Show) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)

        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {return}
        
        detailsViewController.setUserResponseAndAuthInfoAndShow(user: user, authInfo: authInfo, show: show)
        
        let backItem = UIBarButtonItem()
            backItem.title = "Shows"
            navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

// MARK: - Navigate to ProfileDetails

private extension TopRatedViewController {
    func navigateToProfileDetails(user:User, authInfo:AuthInfo) {
        let storyboard = UIStoryboard(name: "ProfileDetails", bundle: nil)

        guard let profileDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ProfileDetailsViewController") as? ProfileDetailsViewController else {return}

       let navigationController = UINavigationController(rootViewController: profileDetailsViewController)

        profileDetailsViewController.setUserResponseAndAuthInfo(user: user, authInfo: authInfo)

       present(navigationController, animated: true)
    }
}

// MARK: - Logout when notified

private extension TopRatedViewController {
    func logoutOnNotification() {
        NotificationCenter.default.removeObserver(notificationToken!)
        let storyboard = UIStoryboard(name: "Login", bundle: nil)

        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {return}

        navigationController?.pushViewController(loginViewController, animated: true)
    }
}
