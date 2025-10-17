//
//  CommentRow.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct CommentRow: View {
    @Environment(\.appDIContainer) private var appDIContainer
    @ObservedObject var postCommentsViewModel: PostCommentsViewModel
    let comment: CommentEntity
    
    var body: some View {
        VStack {
            HStack {
                switch comment.type {
                case CommentType.text.rawValue:
                    appDIContainer.createTextCommentView(comment: comment, postCommentsViewModel: postCommentsViewModel)
                case CommentType.image.rawValue:
                    appDIContainer.createImageCommentView(comment: comment, postCommentsViewModel: postCommentsViewModel)
                case CommentType.audio.rawValue:
                    appDIContainer.createAudioCommentView(comment: comment, postCommentsViewModel: postCommentsViewModel)
                case CommentType.video.rawValue:
                    appDIContainer.createVideoCommentView(comment: comment, postCommentsViewModel: postCommentsViewModel)
                default:
                    EmptyView()
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.leading, CGFloat(comment.depth ?? 0)*30)
        }
    }
}

#Preview {
//    CommentRow(comment: )
}
