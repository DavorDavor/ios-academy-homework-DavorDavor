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

struct ReviewResponse : Codable {
    let review: Review
}

struct Review : Codable {
    let id:String
    let comment:String?
    let rating:Double
    let show_id:Int
    let user:User
}
