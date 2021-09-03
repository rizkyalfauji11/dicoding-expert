//
//  dicoding_expertApp.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 18/08/21.
//

import SwiftUI

@main
struct dicoding_expertApp: App {
    var body: some Scene {
        let getListUseCase = Injection.init().provideHome()
        let homePresenter = HomePresenter(getListUseCase: getListUseCase)
        let favoritePresenter = FavoritePresenter(getListUseCase: getListUseCase)
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
                .environmentObject(favoritePresenter)
        }
    }
}
