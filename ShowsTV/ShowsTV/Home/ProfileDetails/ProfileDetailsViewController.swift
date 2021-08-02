//
//  ProfileDetailsViewController.swift
//  ShowsTV
//
//  Created by Infinum  on 01.08.2021..
//

import UIKit
import Alamofire
import Kingfisher

let NotificationLogoutInit = Notification.Name(rawValue: "NotificationLogoutInit")

class ProfileDetailsViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    // MARK: properties
    var user:User?
    var authInfo:AuthInfo?
    let imagePicker = UIImagePickerController()


    // MARK: outlets
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var reviewInfoLabel: UILabel!

    // MARK: functions, API fetching
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Account"
        usernameLabel.text = user?.email
        imagePicker.delegate = self
        
        if let imageUrl = user?.imageUrl {
        guard let imageUrl = URL(string: imageUrl) else {return}
        profileImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "ic-profile-placeholder"))
        }
        
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
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
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


// MARK: - UIImagePickerControllerDelegate Methods
extension ProfileDetailsViewController {
    
    // picking delegation
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = pickedImage
        }
        guard let image = profileImageView.image else {return}
        storeImage(image)
        
        dismiss(animated: true, completion: nil)
    }

    func storeImage(_ image: UIImage) {
            guard
                let imageData = image.jpegData(compressionQuality: 0.9)
            else { return }
            let requestData = MultipartFormData()
            requestData.append(
                imageData,
                withName: "image",
                fileName: "image.jpg",
                mimeType: "image/jpg"
            )

        AF
        .upload(
            multipartFormData: requestData,
            to: "https://tv-shows.infinum.academy/users",
            method: .put
        )
        .validate()
        .responseDecodable(of: UserResponse.self) {
            //dataResponse in print(dataResponse)
            
            [weak self] dataResponse in
            switch(dataResponse.result) {
            case .success(let userResponse):
                if let imageUrl = userResponse.user.imageUrl {
                    guard
                        let self = self,
                        let imageUrl = URL(string: imageUrl)
                    else {return}
                    self.profileImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "ic-profile-placeholder"))
                }
            case .failure(let error):
                print(error)
            }
        }
     }
    
    // cancel functionality
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
