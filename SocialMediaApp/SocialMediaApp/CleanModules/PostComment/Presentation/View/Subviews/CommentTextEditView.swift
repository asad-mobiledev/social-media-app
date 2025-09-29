//
//  ResizableTextEditView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct CommentTextEditView: View {
    @ObservedObject var postCommentsViewModel: PostCommentsViewModel 
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        TextEditor(text: $postCommentsViewModel.commentText)
            .focused($isFocused)
            .onChange(of: isFocused) { _, isNowFocused in
                if isNowFocused && postCommentsViewModel.commentText == AppText.typeHere {
                    postCommentsViewModel.commentText = ""
                } else if !isNowFocused && postCommentsViewModel.commentText == "" {
                    postCommentsViewModel.commentText = AppText.typeHere
                }
            }
            .frame(maxHeight: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .padding(8)
    }
}

#Preview {
//    CommentTextEditView()
}
