//
//  DetailsViewController.swift
//  ShowsTV
//
//  Created by Infinum  on 28.07.2021..
//

import Foundation
import SVProgressHUD
import Alamofire
import UIKit


class DetailsViewController : UIViewController {
    
    
    // MARK: properties
    var user:User?
    var authInfo:AuthInfo?
    var show:Show?
    
    // MARK: outlets
    
    @IBOutlet private weak var detailsTableView: UITableView!
    @IBOutlet private weak var detailsTitleLabel: UILabel!
    @IBOutlet private weak var detailsDescriptionLabel: UITableView!
    @IBOutlet private weak var detailsRating: UITableView!
    
    
    // MARK: functions, API fetching
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = show?.title
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34, weight: .light)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        


        detailsTitleLabel.text = show?.title
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    func setShow(show:Show){
        self.show = show
    }
    
    func setUserResponseAndAuthInfo(user:User, authInfo:AuthInfo){
        self.user = user
        self.authInfo = authInfo
    }
}

// MARK: - table view row and cell setup
extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: detailsTableViewCell.self),
            for: indexPath
        ) as! detailsTableViewCell
        
//        let cell = tableView.dequeueReusableCell(
//            withIdentifier: String(describing: showsTableViewCell.self),
//            for: indexPath
//        ) as! showsTableViewCell

        cell.configure(with: show!)

        return cell
    }
}

// MARK: - tableView setup

private extension DetailsViewController {

    func setupTableView() {
        detailsTableView.estimatedRowHeight = 110
        detailsTableView.rowHeight = UITableView.automaticDimension

        detailsTableView.tableFooterView = UIView()

        detailsTableView.delegate = self
        detailsTableView.dataSource = self
    }
}

// MARK: - delegation setup
extension DetailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailsTableView.deselectRow(at: indexPath, animated: true)
        guard let show = show else {return}
        print("Selected Item: \(show)")
    }
}
