//
//  UserCommentsView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct CommentsView: View {
    let comments: [CommentModel]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(comments) { comment in
                    CommentRow(comment: comment)
                }
            }
        }
    }
}

#Preview {
    CommentsView(comments: [
        CommentModel(content: "This is the first comment. This is the first comment. This is the first comment.", replies: [
            CommentModel(content: "Reply to first comment. Reply to first comment. Reply to first comment.", replies: [
                CommentModel(content: "Reply to reply. Reply to reply. Reply to reply. Reply to reply.", depth: 2, type: CommentType.video)
            ], depth: 1, type: CommentType.image),
            CommentModel(content: "Another reply to first comment. Another reply to first comment. Another reply to first comment. Another reply to first comment.", depth: 1, type: CommentType.audio)
        ], type: CommentType.text),
        
        CommentModel(content: "This is the first comment. This is the first comment. This is the first comment.", replies: [
            CommentModel(content: "Reply to first comment. Reply to first comment. Reply to first comment.", replies: [
                CommentModel(content: "Reply to reply. Reply to reply. Reply to reply. Reply to reply.", depth: 2, type: CommentType.video)
            ], depth: 1, type: CommentType.image),
            CommentModel(content: "Another reply to first comment. Another reply to first comment. Another reply to first comment. Another reply to first comment.", depth: 1, type: CommentType.audio)
        ], type: CommentType.text),
        
        CommentModel(content: "This is the first comment. This is the first comment. This is the first comment.", replies: [
            CommentModel(content: "Reply to first comment. Reply to first comment. Reply to first comment.", replies: [
                CommentModel(content: "Reply to reply. Reply to reply. Reply to reply. Reply to reply.", depth: 2, type: CommentType.video)
            ], depth: 1, type: CommentType.image),
            CommentModel(content: "Another reply to first comment. Another reply to first comment. Another reply to first comment. Another reply to first comment.", depth: 1, type: CommentType.audio)
        ], type: CommentType.text)]
    )
}
