//
//  TabItem.swift
//  dicoding-expert
//
//  Created by Rizky Alfa Uji Gultom on 26/08/21.
//

import SwiftUI

struct TabItem: View {
    
    var imageName: String
    var title: String
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(title)
        }
    }
    
}
