//
//  ImagePost.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI

struct ImagePost: View {
    let imageName: String
    
    var body: some View {
        VStack {
            ImageView(imageName: imageName)
                .overlay(
                    Rectangle()
                        .stroke(Color.secondary, lineWidth: 4)
                )
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
