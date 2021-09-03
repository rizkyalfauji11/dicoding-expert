//
//  DetailView.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 20/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        ScrollView {
            VStack {
                imageRestaurant
                content
            }
        }
        .edgesIgnoringSafeArea(.all)
        .frame(minHeight: UIScreen.main.bounds.height)
        .navigationBarItems(trailing: Button( action: {
            self.presenter.updateFavoriteRestaurant()
        }){
            if self.presenter.restaurant.isFavorited {
                Image(systemName: "star.fill")
            }
            else{
                Image(systemName: "star")
            }
        })
    }
}


extension DetailView{
    var imageRestaurant: some View {
        WebImage(url: URL(string: self.presenter.restaurant.imageUrl))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(self.presenter.restaurant.name)
                .font(.title)
                .bold()
            
            Text(self.presenter.restaurant.city)
                .font(.system(size: 16))
                .bold()
            
            Text(self.presenter.restaurant.description)
                .font(.system(size: 12))
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
