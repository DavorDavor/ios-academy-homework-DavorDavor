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
    let average_rating:Int
    let description:String
    let image_url:String
    let no_of_reviews:Int
    let title:String
}
