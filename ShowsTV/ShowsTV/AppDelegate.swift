//
//  AppDelegate.swift
//  ShowsTV
//
//  Created by Infinum  on 14.07.2021..
//

import UIKit
import Alamofire

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /*let params: [String : String] = [
            "email" : "lakus.davor@gmail.com",
            "password_confirmation": "infinum1",
            "password_confirmation" : "infinum1"
        ]
        
        AF
            .request("https://tv-shows.infinum.academy/users", method: .post, parameters: params, encoder: JSONParameterEncoder.default)
            .validate()
            .responseJSON(completionHandler: { response in
                result.result
                
            })*/
        return true
    }

    // MARK: UISceneSession Lifecycle

      


}

