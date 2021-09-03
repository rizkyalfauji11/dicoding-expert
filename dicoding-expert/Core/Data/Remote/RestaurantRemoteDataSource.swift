//
//  RestaurantRemoteDataSource.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 19/08/21.
//

import Foundation
import Alamofire
import Combine

protocol RestaurantRemoteDataSourceProtocol: AnyObject {
    func getList() -> AnyPublisher<[RestaurantResponse], Error>
}

final class RestaurantRemoteDataSource: NSObject{
    private override init() {}
    static let sharedInstance: RestaurantRemoteDataSource = RestaurantRemoteDataSource()
}

extension RestaurantRemoteDataSource: RestaurantRemoteDataSourceProtocol{
    func getList() -> AnyPublisher<[RestaurantResponse], Error> {
        return Future<[RestaurantResponse], Error>{ completion in
            if let url = URL(string: Endpoints.Gets.list.url){
                AF.request(url)
                    .validate()
                    .responseDecodable(of: RestaurantsResponse.self){ response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.restaurants))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                        
                    }
            }
        }.eraseToAnyPublisher()
    }
}
