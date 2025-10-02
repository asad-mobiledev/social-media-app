//
//  UserCommentsView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct CommentsView: View {
    @ObservedObject var postCommentsViewModel: PostCommentsViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(postCommentsViewModel.comments) { comment in
                    CommentRow(postCommentsViewModel: postCommentsViewModel, comment: comment)
                        .onAppear {
                            if comment == postCommentsViewModel.comments.last {
                                Task {
                                    await postCommentsViewModel.fetchComments()
                                }
                            }
                        }
                }
            }
        }
        .refreshable {
            if !postCommentsViewModel.isLoading {
                Task {
                    await postCommentsViewModel.refreshPosts()
                }
            }
        }
    }
}

#Preview {
    //    CommentsView(comments: [])
}
