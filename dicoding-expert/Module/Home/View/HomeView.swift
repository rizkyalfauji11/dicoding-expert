//
//  HomeView.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 20/08/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View{
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading")
                    ActivityIndicator()
                }
            }else{
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(
                        self.presenter.restaurants,
                        id: \.id){ restaurant in
                        ZStack{
                            self.presenter.linkBuilder(for: restaurant){
                                RestaurantRow(restaurant: restaurant)
                            }.buttonStyle(PlainButtonStyle())
                        }.padding(8)
                    }
                }
            }
        }.onAppear{
            if presenter.restaurants.isEmpty {
                self.presenter.getRestaurants()
            }
        }
        .navigationBarTitle(
            Text("Restaurant"),
            displayMode: .automatic
            
        ).navigationBarItems(trailing:
                                NavigationLink(destination: ProfileView()){
                                    Image(systemName: "person.crop.circle")
                                        .imageScale(.large)
                                }
        )
    }
}
