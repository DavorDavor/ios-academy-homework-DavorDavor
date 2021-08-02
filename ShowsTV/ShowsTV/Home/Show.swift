//
//  Show.swift
//  ShowsTV
//
//  Created by Infinum  on 26.07.2021..
//

import Foundation


struct ShowsResponse : Codable {
    let shows: [Show]
}

struct Show : Codable {
    let id:String
    let average_rating:Double
    let description:String
    let image_url:String
    let no_of_reviews:Int
    let title:String
}


