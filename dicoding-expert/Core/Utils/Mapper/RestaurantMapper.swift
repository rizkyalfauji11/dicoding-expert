//
//  RestaurantMapper.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 19/08/21.
//

import Foundation

final class RestaurantMapper {
    
    static func mapRestaurantResponsesToEntities(
        input restaurantsResponse: [RestaurantResponse]
    )-> [RestaurantEntity]{
        return restaurantsResponse.map { result in
            let newRestaurant = RestaurantEntity()
            newRestaurant.id = result.id ?? "Unknown"
            newRestaurant.name = result.name ?? "Unknown"
            newRestaurant.pictureId = result.pictureID ?? "Unknown"
            newRestaurant.desc = result.restaurantDescription ?? "Unknown"
            newRestaurant.city = result.city ?? "Unknown"
            newRestaurant.rating = result.rating ?? 0.0
            return newRestaurant
        }
    }
    
    static func mapRestaurantEntitiesToDomains(
        input restaurantEntities: [RestaurantEntity]
    ) -> [RestaurantModel] {
        return restaurantEntities.map { result in        
            return RestaurantModel(
                id: result.id,
                name: result.name ?? "",
                imageUrl: API.baseUrl+"images/medium/"+result.pictureId,
                description: result.desc,
                city: result.city,
                rating: result.rating,
                isFavorited: result.isFavorited
            )
        }
    }
    
    static func mapRestaurantEntityToDomains(
        input entity: RestaurantEntity
    ) -> RestaurantModel {
        return RestaurantModel(
            id: entity.id,
            name: entity.name ?? "",
            imageUrl: API.baseUrl+"images/medium/"+entity.pictureId,
            description: entity.desc,
            city: entity.city,
            rating: entity.rating,
            isFavorited: entity.isFavorited
        )
        
    }
    
    static func mapRestaurantResponsesToDomains(
        input restaurantResponses: [RestaurantResponse]
    ) -> [RestaurantModel] {
        
        return restaurantResponses.map { result in
            let pictureId = result.pictureID ?? ""
            return RestaurantModel(
                id: result.id ?? "",
                name: result.name ?? "Unknown",
                imageUrl: pictureId,
                description: result.restaurantDescription ?? "Unknown",
                city: result.city ?? "Unknown",
                rating: result.rating ?? 0.0,
                isFavorited: false
            )
        }
    }
}
