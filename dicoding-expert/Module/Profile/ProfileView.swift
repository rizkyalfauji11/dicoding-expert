//
//  ProfileView.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 27/08/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            Spacer()
            Image("profile")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .shadow(radius: 10)
                .frame(height: 300)
            
            Text("Rizky Alfa Uji Gultom")
                .padding()
            Text("rizkyalfauji11@gmail.com")
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
