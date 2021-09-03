//
//  RestaurantRow.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 20/08/21.
//

import SwiftUI
import SDWebImageSwiftUI
import CorePackage

struct RestaurantRow: View {
    var restaurant: RestaurantModel
    
    var body: some View {
        VStack{
            imageRestaurant
            content
        }
    }
}

extension RestaurantRow {
    
    var imageRestaurant: some View {
        WebImage(url: URL(string: restaurant.imageUrl))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .cornerRadius(10)
            .padding(.top)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(restaurant.name)
                .font(.title)
                .bold()
            
            Text(restaurant.city)
                .font(.system(size: 16))
                .bold()
            
            Text(restaurant.description)
                .font(.system(size: 14))
                .lineLimit(2)
        }.padding(
            EdgeInsets(
                top: 0,
                leading: 8,
                bottom: 8,
                trailing: 8
            )
        )
    }
    
}

