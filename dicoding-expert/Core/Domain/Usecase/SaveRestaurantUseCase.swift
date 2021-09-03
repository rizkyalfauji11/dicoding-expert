//
//  SaveRestaurantUseCase.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 20/08/21.
//

import Foundation
import Combine

protocol SaveRestaurantUseCase {
    func updateFavoriteRestaurant() -> AnyPublisher<RestaurantModel, Error>
    func getRestaurant() -> RestaurantModel
    func getRestaurant() -> AnyPublisher<RestaurantModel, Error>
}

class SaveRestaurantInteractor: SaveRestaurantUseCase{
    
    private var repository: RestaurantRepositoryProtocol
    private let restaurant: RestaurantModel
    
    required init(
        repository: RestaurantRepositoryProtocol,
        restaurant: RestaurantModel
    ){
        self.restaurant = restaurant
        self.repository = repository
    }
    
    func updateFavoriteRestaurant() -> AnyPublisher<RestaurantModel, Error> {
        return repository.updateFavoriteRestaurant(by: self.restaurant.id)
    }
    
    func getRestaurant() -> RestaurantModel {
        return restaurant
    }
    
    func getRestaurant() -> AnyPublisher<RestaurantModel, Error> {
        return repository.getRestaurant(by: restaurant.id)
    }
    
}
