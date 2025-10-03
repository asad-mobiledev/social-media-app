//
//  ResizableTextEditView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct TextFieldView: View {
    @ObservedObject var postCommentsViewModel: PostCommentsViewModel
    
    var body: some View {
        TextField(AppText.typeHere, text: $postCommentsViewModel.commentText)
            .padding(12)
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
