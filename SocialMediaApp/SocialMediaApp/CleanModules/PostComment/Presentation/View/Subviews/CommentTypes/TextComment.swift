//
//  TextComment.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct TextComment: View {
    @ObservedObject var postCommentsViewModel: PostCommentsViewModel
    let comment: CommentEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(comment.text!)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .font(.body)
                .foregroundStyle(Color.black)
            
            CommentsReplyView(postCommentsViewModel: postCommentsViewModel, comment: comment)
        }
        
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.lightGray)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .padding(.horizontal, 10)
    }
}

#Preview {
//    TextComment(text: "Test Comment ", depth: 1)
}
