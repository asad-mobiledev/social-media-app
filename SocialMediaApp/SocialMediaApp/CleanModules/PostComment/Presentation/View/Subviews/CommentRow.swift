//
//  CommentRow.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct CommentRow: View {
    @Environment(\.appDIContainer) private var appDIContainer
    let comment: CommentEntity
    
    var body: some View {
        VStack {
            HStack {
                switch comment.type {
                case CommentType.text.rawValue:
                    TextComment(text: comment.text ?? "", depth: Int(comment.depth ?? "0")!)
                case CommentType.image.rawValue:
                    appDIContainer.createImageCommentView(imageName: comment.mediaName!, depth: Int(comment.depth ?? "0")!)
                case CommentType.audio.rawValue:
                    appDIContainer.createAudioCommentView(resourceName: comment.mediaName!, depth: Int(comment.depth ?? "0")!)
                case CommentType.video.rawValue:
                    appDIContainer.createVideoCommentView(resourceName: comment.mediaName!, depth: Int(comment.depth ?? "0")!)
                default:
                    EmptyView()
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.leading, CGFloat(Int(comment.depth ?? "0")!*30))
            
//            ForEach(comment.replies) { replyComment in
//                CommentRow(comment: replyComment)
//            }
        }
    }
}

#Preview {
//    CommentRow(comment: )
}
