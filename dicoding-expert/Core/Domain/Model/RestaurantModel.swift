//
//  RestaurantModel.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 19/08/21.
//

import Foundation

struct RestaurantModel: Equatable, Identifiable {
    let id: String
    let name: String
    let imageUrl: String
    let description: String
    let city: String
    let rating: Double
    let isFavorited: Bool
}
