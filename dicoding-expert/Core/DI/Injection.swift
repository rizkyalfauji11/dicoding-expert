//
//  Injection.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 19/08/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  
  private func provideRepository() -> RestaurantRepositoryProtocol {
    let realm = try? Realm()

    let locale: RestaurantaLocalDataSource = RestaurantaLocalDataSource.sharedInstance(realm)
    let remote: RestaurantRemoteDataSource = RestaurantRemoteDataSource.sharedInstance

    return RestaurantRepository.sharedInstance(locale, remote)
  }

  func provideHome() -> GetRestaurantsUseCase {
    let repository = provideRepository()
    return GetRestaurantInteractor(repository: repository)
  }

  func provideDetail(restaurant: RestaurantModel) -> SaveRestaurantUseCase {
    let repository = provideRepository()
    return SaveRestaurantInteractor(repository: repository, restaurant: restaurant)
  }
}
