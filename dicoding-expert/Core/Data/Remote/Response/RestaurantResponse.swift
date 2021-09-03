//
//  RestaurantResponse.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 19/08/21.
//

import Foundation

struct RestaurantsResponse: Codable {
    let error: Bool
    let message: String
    let count: Int
    let restaurants: [RestaurantResponse]
}

struct RestaurantResponse: Codable {
    let id, name, restaurantDescription, pictureID: String?
    let city: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case id, name
        case restaurantDescription = "description"
        case pictureID = "pictureId"
        case city, rating
    }
}
