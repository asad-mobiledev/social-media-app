//
//  ImagePost.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI

struct ImagePost: View {
    @Environment(\.appDIContainer) private var appDIContainer
    let post: PostEntity
    
    var body: some View {
        VStack {
            appDIContainer.createNamedImageView(imageName: post.mediaName)
            HStack {
                let commentOrComments = post.commentsCount > 1 ? "comments": "comment"
                let commentButtonText = "\(post.commentsCount) \(commentOrComments)"
                Button(commentButtonText) {
                    print("Comments Button Tapped")
                }
                .font(.system(size: 12))
                .foregroundStyle(Color.black)

                Spacer()
                
                CommentButton(post: post)
                    .padding(.trailing, 5)
                    .padding(.bottom, 5)
            }
        }
        .background(Color.secondary)
        .overlay(
            Rectangle()
                .stroke(Color.secondary, lineWidth: 4)
        )
    }
}

#Preview {
//    ImagePost(imageName: "post-image")
}
