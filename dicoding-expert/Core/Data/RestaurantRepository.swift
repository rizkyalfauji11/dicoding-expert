//
//  RestaurantRepository.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 19/08/21.
//

import Foundation
import Combine

protocol RestaurantRepositoryProtocol {
    func getList(isFavorite: Bool) -> AnyPublisher<[RestaurantModel], Error>
    func updateFavoriteRestaurant(by id: String)->AnyPublisher<RestaurantModel, Error>
    func getRestaurant(by id: String) -> AnyPublisher<RestaurantModel, Error>
}

final class RestaurantRepository: NSObject{
    typealias RestaurantInstance = (RestaurantaLocalDataSource, RestaurantRemoteDataSource) -> RestaurantRepository
    
    fileprivate let remote: RestaurantRemoteDataSource
    fileprivate let local: RestaurantaLocalDataSource
    
    private init(local: RestaurantaLocalDataSource, remote: RestaurantRemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    static let sharedInstance: RestaurantInstance = { localRepo, remoteRepo in
        return RestaurantRepository(local: localRepo, remote: remoteRepo)
    }
}

extension RestaurantRepository: RestaurantRepositoryProtocol{
    func getRestaurant(by id: String) -> AnyPublisher<RestaurantModel, Error> {
        return self.local.getRestaurant(by: id)
            .map {
                RestaurantMapper.mapRestaurantEntityToDomains(input: $0)
            }
            .eraseToAnyPublisher()
    }
    
    func updateFavoriteRestaurant(by id: String) -> AnyPublisher<RestaurantModel, Error> {
        return self.local.updateFavoriteStatus(by: id)
            .map { RestaurantMapper.mapRestaurantEntityToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getList(isFavorite: Bool) -> AnyPublisher<[RestaurantModel], Error> {
        return self.local.getList(isFavorite: isFavorite)
            .flatMap { result -> AnyPublisher<[RestaurantModel], Error> in
                if result.isEmpty {
                    return self.remote.getList()
                        .map { RestaurantMapper.mapRestaurantResponsesToEntities(input: $0) }
                        .flatMap { self.local.addRestaurant(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getList(isFavorite: isFavorite)
                            .map { RestaurantMapper.mapRestaurantEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.local.getList(isFavorite: isFavorite)
                        .map { RestaurantMapper.mapRestaurantEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
}
