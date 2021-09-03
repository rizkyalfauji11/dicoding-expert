//
//  HomeRouter.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 20/08/21.
//

import SwiftUI

class HomeRouter {
    func makeDetailView(for restaurant: RestaurantModel) -> some View {
        let usecase = Injection.init().provideDetail(restaurant: restaurant)
        let presenter = DetailPresenter(favoriteUseCase: usecase)
        return DetailView(presenter: presenter)
    }
}
