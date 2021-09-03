//
//  DetailPresenter.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 20/08/21.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private var favoriteRestaurantUseCase: SaveRestaurantUseCase
    
    @Published var restaurant: RestaurantModel
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    init(favoriteUseCase: SaveRestaurantUseCase) {
        self.favoriteRestaurantUseCase = favoriteUseCase
        self.restaurant = favoriteRestaurantUseCase.getRestaurant()
    }
    
    func updateFavoriteRestaurant() {
        favoriteRestaurantUseCase.updateFavoriteRestaurant()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { restaurant in
                self.restaurant = restaurant
            }).store(in: &cancellables)
    }
    
}
