//
//  ImageView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI
import Zoomable

struct ImageView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height:200)
            .clipShape(.rect())
            .zoomable(minZoomScale: 0.5)
    }
}

#Preview {
    ImageView(imageName: "post-image")
}
