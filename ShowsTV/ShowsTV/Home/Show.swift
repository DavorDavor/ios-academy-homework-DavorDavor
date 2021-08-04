//
//  Show.swift
//  ShowsTV
//
//  Created by Infinum  on 26.07.2021..
//

import Foundation


struct ShowsResponse: Codable {
    let shows: [Show]
}

struct Show: Codable {
    let id:String
    let averageRating:Double
    let description:String
    let imageUrl:URL?
    let noOfReviews:Int
    let title:String
    
    enum CodingKeys: String, CodingKey {
        case id
        case averageRating = "average_rating"
        case description
        case imageUrl = "image_url"
        case noOfReviews = "no_of_reviews"
        case title
    }
}


