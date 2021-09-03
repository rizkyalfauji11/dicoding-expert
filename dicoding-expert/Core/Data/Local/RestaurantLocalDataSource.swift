//
//  RestaurantLocalDataSource.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 19/08/21.
//

import Foundation
import Combine
import RealmSwift

protocol RestaurantLocalDataSourceProtocol: AnyObject {
    func getList(isFavorite: Bool) -> AnyPublisher<[RestaurantEntity], Error>
    func addRestaurant(from restaurants: [RestaurantEntity])-> AnyPublisher<Bool, Error>
    func updateFavoriteStatus(by id: String) -> AnyPublisher<RestaurantEntity, Error>
    func getRestaurant(by id: String) -> AnyPublisher<RestaurantEntity, Error>
    func getAllList() -> AnyPublisher<[RestaurantEntity], Error>
    func getFavoriteList() -> AnyPublisher<[RestaurantEntity], Error>
}

final class RestaurantaLocalDataSource: NSObject{
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> RestaurantaLocalDataSource = { realmDatabase in
        return RestaurantaLocalDataSource(realm: realmDatabase)
    }
}

extension RestaurantaLocalDataSource: RestaurantLocalDataSourceProtocol{
    func getAllList() -> AnyPublisher<[RestaurantEntity], Error> {
        return Future<[RestaurantEntity], Error> { completion in
            if let realm = self.realm {
                let restaurants: Results<RestaurantEntity> = {
                    realm.objects(RestaurantEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(restaurants.toArray(ofType: RestaurantEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavoriteList() -> AnyPublisher<[RestaurantEntity], Error> {
        return Future<[RestaurantEntity], Error> { completion in
            if let realm = self.realm {
                let restaurants: Results<RestaurantEntity> = {
                    realm.objects(RestaurantEntity.self)
                        .filter("isFavorited = %@", true)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(restaurants.toArray(ofType: RestaurantEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getRestaurant(by id: String) -> AnyPublisher<RestaurantEntity, Error> {
        return Future<RestaurantEntity, Error> { completion in
            if let realm = self.realm {
                let restaurants: Results<RestaurantEntity> = {
                    realm.objects(RestaurantEntity.self)
                        .filter("id = '\(id)'")
                }()
                
                guard let restaurant = restaurants.first else {
                    completion(.failure(DatabaseError.requestFailed))
                    return
                }
                
                completion(.success(restaurant))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateFavoriteStatus(by id: String) -> AnyPublisher<RestaurantEntity, Error> {
        return Future<RestaurantEntity, Error> { completion in
            if let realm = self.realm, let restaurantEntity = {
                realm.objects(RestaurantEntity.self).filter("id = '\(id)'")
            }().first {
                do {
                    try realm.write {
                        restaurantEntity.setValue(!restaurantEntity.isFavorited, forKey: "isFavorited")
                    }
                    completion(.success(restaurantEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getList(isFavorite: Bool) -> AnyPublisher<[RestaurantEntity], Error> {
        if isFavorite {
            return getFavoriteList()
        }else{
            return getAllList()
        }
    }
    
    func addRestaurant(from restaurants: [RestaurantEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for restaurant in restaurants {
                            realm.add(restaurant, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
