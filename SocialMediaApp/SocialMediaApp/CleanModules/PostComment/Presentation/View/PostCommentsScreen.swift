//
//  PostDetailScreen.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI
import AVKit

struct PostCommentsScreen: View {
    @Environment(\.appDIContainer) private var appDIContainer
    @StateObject var postCommentsViewModel: PostCommentsViewModel
    @State private var showBottomSheet = false

    var body: some View {
        VStack(spacing: 0) {
            
            ScrollView {
                switch postCommentsViewModel.post.postType {
                case .image:
                    appDIContainer.createNamedImageView(imageName: postCommentsViewModel.post.mediaName)
                        .overlay(
                            Rectangle()
                                .stroke(Color.secondary, lineWidth: 4)
                        )
                case .video:
                    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
                    VideoView(videoName: postCommentsViewModel.post.mediaName)
                case .audio:
                    let audioURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
                    AudioView(resourceName: postCommentsViewModel.post.mediaName)
                }
                CommentsView(comments: [
                    DummyCommentModel(content: "This is the first comment. This is the first comment. This is the first comment.", replies: [
                        DummyCommentModel(content: "Reply to first comment. Reply to first comment. Reply to first comment.", replies: [
                            DummyCommentModel(content: "Reply to reply. Reply to reply. Reply to reply. Reply to reply.", depth: 2, type: CommentType.video)
                        ], depth: 1, type: CommentType.image),
                        DummyCommentModel(content: "Another reply to first comment. Another reply to first comment. Another reply to first comment. Another reply to first comment.", depth: 1, type: CommentType.audio)
                    ], type: CommentType.text),
                    
                    DummyCommentModel(content: "This is the first comment. This is the first comment. This is the first comment.", replies: [
                        DummyCommentModel(content: "Reply to first comment. Reply to first comment. Reply to first comment.", replies: [
                            DummyCommentModel(content: "Reply to reply. Reply to reply. Reply to reply. Reply to reply.", depth: 2, type: CommentType.video)
                        ], depth: 1, type: CommentType.image),
                        DummyCommentModel(content: "Another reply to first comment. Another reply to first comment. Another reply to first comment. Another reply to first comment.", depth: 1, type: CommentType.audio)
                    ], type: CommentType.text),
                    
                    DummyCommentModel(content: "This is the first comment. This is the first comment. This is the first comment.", replies: [
                        DummyCommentModel(content: "Reply to first comment. Reply to first comment. Reply to first comment.", replies: [
                            DummyCommentModel(content: "Reply to reply. Reply to reply. Reply to reply. Reply to reply.", depth: 2, type: CommentType.video)
                        ], depth: 1, type: CommentType.image),
                        DummyCommentModel(content: "Another reply to first comment. Another reply to first comment. Another reply to first comment. Another reply to first comment.", depth: 1, type: CommentType.audio)
                    ], type: CommentType.text)]
                )
            }
            AddCommentView(postCommentsViewModel: postCommentsViewModel, showBottomSheet: $showBottomSheet)
        }
        .sheet(isPresented: $showBottomSheet) {
            appDIContainer.createPostBottomSheet()
            .presentationDetents([.height(250)])
            .presentationDragIndicator(.visible)
        }
        .onAppear {
            Task {
                await postCommentsViewModel.fetchComments()
            }
        }
    }
}

#Preview {
//    PostDetailScreen(type: .video)
}
