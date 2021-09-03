//
//  APICall.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 19/08/21.
//

import Foundation

struct API{
    static let baseUrl = "https://restaurant-api.dicoding.dev/"
}

protocol Endpoint{
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint{
        case list
        case search
        case detail
        
        public var url: String{
            switch self {
            case .list: return "\(API.baseUrl)list"
            case .detail: return "\(API.baseUrl)detail/"
            case .search: return "\(API.baseUrl)search?q="
            }
        }
    }
}
