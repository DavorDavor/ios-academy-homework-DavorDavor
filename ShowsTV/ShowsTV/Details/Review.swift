//
//  Review.swift
//  ShowsTV
//
//  Created by Infinum  on 28.07.2021..
//

import Foundation

struct ReviewsResponse : Codable {
    let reviews: [Review]
}

struct Review : Codable {
    let id:String
    let comment:String
    let rating:Int
    let show_id:Int
    let user:User
}
