//
//  CommentsCountAndButtonView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/10/2025.
//

import SwiftUI

struct CommentsCountAndButtonView: View {
    let post: PostEntity
    
    var body: some View {
        HStack {
            Spacer()
            Spacer()
            let commentOrComments = post.commentsCount > 1 ? "comments...": "comment..."
            let commentButtonText = "\(post.commentsCount) \(commentOrComments)"
            Text(commentButtonText)
            .font(.system(size: 16))
            .foregroundStyle(Color.primary)

            Spacer()
            
            CommentButton(post: post)
                .padding(.trailing, 5)
                .padding(.bottom, 5)
        }
    }
}

#Preview {
//    CommentsCountAndButtonView()
}
