//
//  CommentRow.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct CommentRow: View {
    let comment: DummyCommentModel
    var body: some View {
        VStack {
            HStack {
                switch comment.type {
                case .text:
                    TextComment(text: comment.content, depth: comment.depth)
                case .image:
                    ImageComment(imageName: Images.postImage, depth: comment.depth)
                case .audio:
                    AudioComment(videoURL: Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!, depth: comment.depth)
                case .video:
                    VideoComment(videoURL: Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!, depth: comment.depth)
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.leading, CGFloat(comment.depth*30))
            
            ForEach(comment.replies) { replyComment in
                CommentRow(comment: replyComment)
            }
        }
    }
}

#Preview {
    CommentRow(comment: DummyCommentModel(content: "This is the first comment. This is the first comment. This is the first comment.", replies: [
        DummyCommentModel(content: "Reply to first comment. Reply to first comment. Reply to first comment.", replies: [
            DummyCommentModel(content: "Reply to reply. Reply to reply. Reply to reply. Reply to reply.", depth: 2, type: CommentType.video)
        ], depth: 1, type: CommentType.image),
        DummyCommentModel(content: "Another reply to first comment. Another reply to first comment. Another reply to first comment. Another reply to first comment.", depth: 1, type: CommentType.audio)
    ], type: CommentType.text))
}
