//
//  ImagePost.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI
import Zoomable

struct ImagePost: View {
    let imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height:200)
                .clipShape(.rect())
                .overlay(
                    Rectangle()
                        .stroke(Color.secondary, lineWidth: 4)
                )
                .zoomable(minZoomScale: 0.5)
                
            
            HStack {
                Spacer()
                CommentButton()
                    .padding(.trailing, 5)
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
        }
        .background(Color.secondary)
    }
}

#Preview {
    ImagePost(imageName: "post-image")
}
