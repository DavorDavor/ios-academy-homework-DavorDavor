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

protocol ReviewViewControllerDelegate: AnyObject {
    func didAddReview(review: Review)
}

class ReviewViewController : UIViewController {
    
    
    // MARK: properties
    var user:User?
    var authInfo:AuthInfo?
    var show:Show?
    weak var delegate: ReviewViewControllerDelegate?

    
    // MARK: outlets
    
    @IBOutlet private weak var ratingView: RatingView!
    @IBOutlet private weak var reviewComment: UITextField!
    @IBOutlet private weak var submitButton: UIButton!

    
    
    // MARK: functions, API fetching
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Write a Review"
        if let show = show {
            self.ratingView.setRoundedRating(show.averageRating)
        }

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
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    
    func setUserResponseAndAuthInfoAndShow(user:User, authInfo:AuthInfo, show:Show) {
        self.user = user
        self.authInfo = authInfo
        self.show = show
    }
    
    // enable submitting on comment being entered
    @IBAction private func commentBeingEntered(_ sender: Any) {
        guard let comment = reviewComment.text else { return }
        if comment.isEmpty {
            reviewComment.alpha = 0.6
            submitButton.alpha = 0.6
            submitButton.isEnabled = false
        } else {
            reviewComment.alpha = 1
            submitButton.isEnabled = true
            submitButton.alpha = 1
        }
    }
    
    @IBAction private func submitAReviewOnClick(_ sender: Any) {
        guard let comment = reviewComment.text else {return}
        let rating = ratingView.rating
        guard let show = show else {return}
        guard let id = Int(show.id) else {return}
        // API call
        postAComment(rating: rating, comment: comment, showId: id)
    }
}

extension ReviewViewController {
    func postAComment(rating: Int, comment: String, showId: Int) {
        
        let parameters: [String : String] = [
            "comment": comment,
            "rating": String(rating),
            "show_id" : String(showId)
        ]
        
        guard let authInfo = authInfo else {return}
        AF .request(
           "https://tv-shows.infinum.academy/reviews",
                method: .post,
                parameters: parameters,
                headers: HTTPHeaders(authInfo.headers)
            )
            .validate()
            .responseDecodable(of: ReviewResponse.self) { [weak self] dataResponse in
               switch dataResponse.result {
               case .success(let reviewResponse):
                    guard let self = self else {return}
                    guard let delegate = self.delegate else {return}
                    delegate.didAddReview(review: reviewResponse.review)
                    // navigation back
                    self.dismiss(animated: true, completion: nil)
               case .failure(let error):
                   print("Error parsing data: \(error)")
                    guard let self = self else { return }
                    let alert = UIAlertController(title: "Review posting error", message: "\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
               }
            }
    }
}
