//
//  ImagePost.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI

struct ImagePost: View {
    @Environment(\.appDIContainer) private var appDIContainer
    let fileURL: URL
    
    var body: some View {
        VStack {
            appDIContainer.createPostImageView(url: fileURL)
                .overlay(
                    Rectangle()
                        .stroke(Color.secondary, lineWidth: 4)
                )
            HStack {
                Spacer()
                CommentButton(type: .image)
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
//    ImagePost(url: url)
}
