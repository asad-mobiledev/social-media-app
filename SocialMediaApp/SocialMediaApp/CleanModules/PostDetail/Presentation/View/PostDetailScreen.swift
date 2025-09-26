//
//  PostDetailScreen.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI
import AVKit

struct PostDetailScreen: View {
    @Environment(\.appDIContainer) private var appDIContainer
    @StateObject var postDetailViewModel: PostDetailViewModel
    @State private var showBottomSheet = false

    var body: some View {
        VStack(spacing: 0) {
            
            ScrollView {
                switch postDetailViewModel.post.postType {
                case .image:
                    appDIContainer.createNamedImageView(imageName: postDetailViewModel.post.mediaName)
                        .overlay(
                            Rectangle()
                                .stroke(Color.secondary, lineWidth: 4)
                        )
                case .video:
                    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
                    VideoView(videoName: postDetailViewModel.post.mediaName)
                case .audio:
                    let audioURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
                    AudioView(resourceName: postDetailViewModel.post.mediaName)
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
            AddCommentView(showBottomSheet: $showBottomSheet)
        }
        .sheet(isPresented: $showBottomSheet) {
            appDIContainer.createPostBottomSheet()
            .presentationDetents([.height(250)])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
//    PostDetailScreen(type: .video)
}
