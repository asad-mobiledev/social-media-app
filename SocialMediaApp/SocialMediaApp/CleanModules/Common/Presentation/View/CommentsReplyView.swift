//
//  CommentsReplyView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/10/2025.
//

import SwiftUI

struct CommentsReplyView: View {
    @ObservedObject var postCommentsViewModel: PostCommentsViewModel
    let comment: CommentEntity
    
    var body: some View {
        HStack {
            if !comment.repliesLoaded {
                if let replyCount = Int(comment.replyCount ?? "0"), replyCount > 0 {
                    Button("view \(replyCount) replies...") {
                        Task {
                            await postCommentsViewModel.fetchComments(parentCommentId: comment.id)
                        }
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(Color.black)
                    .padding(.trailing, 5)
                }
            }
            
            if comment.depth! < 2 {
                Button(AppText.reply) {
                    postCommentsViewModel.replyToComment = comment
                }
                .font(.system(size: 12))
                .foregroundStyle(Color.primary)
                .padding(.trailing, 0)
            }
        }
    }
}

#Preview {
//    CommentsReplyView()
}
