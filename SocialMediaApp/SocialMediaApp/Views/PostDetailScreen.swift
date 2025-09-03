//
//  PostDetailScreen.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct PostDetailScreen: View {
    let type: PostType
    
    var body: some View {
        ScrollView {
            switch type {
            case .image:
                ImageView(imageName: "post-image")
                    .overlay(
                        Rectangle()
                            .stroke(Color.secondary, lineWidth: 4)
                    )
            case .video:
                let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
                VideoView(videoURL: videoURL)
            case .audio:
                let audioURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
                AudioView(audioURL: audioURL)
            }
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
        AddCommentView()
    }
}

#Preview {
    PostDetailScreen(type: .video)
}
