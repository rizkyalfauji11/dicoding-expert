//
//  GetRestaurantsUseCase.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 20/08/21.
//

import Foundation
import Combine

protocol GetRestaurantsUseCase {
    func getList(isFavorite: Bool) -> AnyPublisher<[RestaurantModel], Error>
}

class GetRestaurantInteractor: GetRestaurantsUseCase {
    private let repository: RestaurantRepositoryProtocol
    
    required init(repository: RestaurantRepositoryProtocol){
        self.repository = repository
    }
    func getList(isFavorite: Bool) -> AnyPublisher<[RestaurantModel], Error> {
        return repository.getList(isFavorite: isFavorite)
    }
}
