//
//  ContentView.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 18/08/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    var body: some View {
        TabView{
            NavigationView{
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }

            NavigationView{
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                TabItem(imageName: "star.fill", title: "favorite")
            }
        }
            
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
