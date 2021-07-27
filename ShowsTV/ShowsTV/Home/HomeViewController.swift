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
    // Delegate UI events, open up `UITableViewDelegate` and explore :)

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showsTableView.deselectRow(at: indexPath, animated: true)
        let show = shows?.shows[indexPath.row]
        print("Selected Item: \(show)")
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

        print("CURRENT INDEX PATH BEING CONFIGURED: \(indexPath)")

        // We need to dequeue the instance of `UITableViewCell`
        // What does that even mean right??
        // Well in order for our scrolling TVShows to perform smoothly,
        // OS will try and reuse table view cells to achieve 60 FPS while scrolling

        // How will it achieve that?
        // Well once the cell goes off screen, it will be prepared for reuse for
        // the next data set (next TVShowItem)
        // This will keep memory in check.

        // If we are using Storyboards or XIBs to create table view cells
        // we need to use some sort of identifier, so that the system later
        // on knows which cell to reuse

        // Identifier should be setup inside the interface builder, rule of
        // thumb is to set it to be named as the subclass that we use
        // When you select your UITableViewCell in IB, yo can go to the
        // Attributes Inspector (fifth icon in the right menu) and there you can
        // setup the Identifier.

        // For that reason, we don't need to use String which is error prone
        // but we can use class name and convert it to String

        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: showsTableViewCell.self),
            for: indexPath
        ) as! showsTableViewCell

        // Once we get a reference to UITableViewCell, more specifically our special
        // subclass, we want to configure it with our data
        // As we have already learned to not leak implementation details, in this case
        // that would mean our label and image, we need to pass in the data
        // With this in place, adhere to Encapsulation principle of object oriented programming
        // Yes sure we can improve this further by using a protocol, but for now we will settle on this approach

        cell.configure(with: shows!.shows[indexPath.row])

        // After our special cell is configured, we just return it so that it can be displayed

        return cell
    }
}

// MARK: - Private

private extension HomeViewController {

    func setupTableView() {
        // For now we are using automatic height, that means that the table view
        // cell will try to callculate its own size
        // For the system to knows that we plan to do that, we need to specifiy some estimated row height
        showsTableView.estimatedRowHeight = 110
        showsTableView.rowHeight = UITableView.automaticDimension

        // Little trick to remove empty table view cells from the screen, play with removing it.
        showsTableView.tableFooterView = UIView()

        // Setup delegate and data source
        // Both of these are using delegate pattern
        // One "delegate" is for providing data
        // One "delegate" is for providing responses to various UI events, like row tap ...
        // You can set those two in the interface builder as well
        showsTableView.delegate = self
        showsTableView.dataSource = self
    }
}
