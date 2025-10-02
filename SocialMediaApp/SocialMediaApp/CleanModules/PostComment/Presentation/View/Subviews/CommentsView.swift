//
//  UserCommentsView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct CommentsView: View {
    let comments: [CommentEntity]
    
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
    CommentsView(comments: [])
}
