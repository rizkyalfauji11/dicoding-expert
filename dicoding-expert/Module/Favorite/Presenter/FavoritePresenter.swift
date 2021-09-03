//
//  FavoritePresenter.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 26/08/21.
//

import SwiftUI
import Combine
import CorePackage

class FavoritePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let getListUseCase: GetRestaurantsUseCase
    
    @Published var restaurants: [RestaurantModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(getListUseCase: GetRestaurantsUseCase) {
        self.getListUseCase = getListUseCase
    }
    
    func getRestaurants() {
        loadingState = true
        getListUseCase.getList(isFavorite: true)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { restaurants in
                self.restaurants = restaurants
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for restaurant: RestaurantModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: restaurant)) { content() }
    }
}
