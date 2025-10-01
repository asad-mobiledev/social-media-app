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
                    appDIContainer.createVideoPlayerView(resourceName: postCommentsViewModel.post.mediaName)
                        .overlay(
                            Rectangle()
                                .stroke(Color.secondary, lineWidth: 4)
                        )
                case .audio:
                    appDIContainer.createAudioPlayerView(resourceName: postCommentsViewModel.post.mediaName)
                        .overlay(
                            Rectangle()
                                .stroke(Color.secondary, lineWidth: 4)
                        )
                }
            }
            AddCommentView(postCommentsViewModel: postCommentsViewModel)
        }
        .sheet(isPresented: $postCommentsViewModel.showBottomSheet) {
            // Create a Separate View For Import Media Comments and initialize view model from DI container instead of here.
            appDIContainer.importMediaBottomSheet(importMediaBottomSheetViewModel: ImportMediaBottomSheetViewModel())
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
