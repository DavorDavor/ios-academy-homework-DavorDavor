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
    let average_rating:Int
    let description:String
    let image_url:String
    let no_of_reviews:Int
    let title:String


    // MARK: Helpers

//    init(headers: [String: String]) throws {
//        let data = try JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted)
//        let decoder = JSONDecoder()
//        self = try decoder.decode(Self.self, from: data)
//    }
//
//    var headers: [String: String] {
//        do {
//            let data = try JSONEncoder().encode(self)
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
//            return jsonObject as? [String: String] ?? [:]
//        } catch {
//            return [:]
//        }
//    }

}


