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
    private var reviews:ReviewsResponse?
    
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
        
        SVProgressHUD.show()
        setupTableView()
        guard let authInfo = authInfo else {return}
        guard let show = show else {return}
        let show_id = show.id
     AF .request(
        "https://tv-shows.infinum.academy/shows/\(show_id)/reviews",
             method: .get,
             parameters: ["page": "1", "items": "100"], // pagination arguments
             headers: HTTPHeaders(authInfo.headers)
         )
         .validate()
         .responseDecodable(of: ReviewsResponse.self) { [weak self] dataResponse in
            switch dataResponse.result {
            case .success(let reviewsResponse):
                guard let self = self else {return}
                self.setReviews(reviews: reviewsResponse)
                SVProgressHUD.showSuccess(withStatus: "Success")
            case .failure(let error):
                print("Error parsing data: \(error)")
                SVProgressHUD.showError(withStatus: "Failure")
            }
         }
    }
    
    // hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    func setReviews(reviews:ReviewsResponse){
        self.reviews = reviews
        detailsTableView.reloadData()
    }
    
    func setUserResponseAndAuthInfoAndShow(user:User, authInfo:AuthInfo, show:Show) {
        self.user = user
        self.authInfo = authInfo
        self.show = show
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
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//           if let string = self.tableData[indexPath.row] as? String
//           {
//               let cell:CustomCountryCell = self.tableView.dequeueReusableCell(withIdentifier: "customCountryCell") as! CustomCountryCell
//
//               cell.countryName?.text = string
//               cell.countryIcon?.image = UIImage(named:string)
//               return cell
//           }
//
//           else if let population = self.tableData[indexPath.row] as? Any, population is Double || population is Int {
//
//               let cell:CustomPopulationCell = self.tableView.dequeueReusableCell(withIdentifier: "customPopulationCell") as! CustomPopulationCell
//
//               cell.countryPopulation?.text = "Population is \(population) million"
//
//               return cell
//
//           }
//
//           return UITableViewCell()
//
//       }
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
