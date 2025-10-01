//
//  AddCommentView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct AddCommentView: View {
    @ObservedObject var postCommentsViewModel: PostCommentsViewModel
    
    var body: some View {
        HStack(alignment: .center){
            CommentTextEditView(postCommentsViewModel: postCommentsViewModel)
            
            Button(action: {
                postCommentsViewModel.showBottomSheet = true
            }) {
                Image(systemName: Images.upload)
                    .font(.title)
                    .foregroundColor(.black)
            }
            
            Button(action: {
                Task {
                    // commenting on a post
                    await postCommentsViewModel.addComment()
                    // Replying to specific comment, add specific comment's id and it's depth will be treated as parentCommentDepth.
//                    await postCommentsViewModel.addComment(parentCommentId: "C0C0C98C-F1DF-4696-B89C-B1BE956595A6", parentCommentDepth: "0")
                     
                }
            }) {
                SendImage()
                    .foregroundColor(Color.primary)
            }
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
//    StatefulPreviewWrapper(false) { binding in
//            AddCommentView(showBottomSheet: binding)
//        }
}



