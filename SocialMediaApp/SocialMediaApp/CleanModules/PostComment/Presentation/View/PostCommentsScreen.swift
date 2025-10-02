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
    @EnvironmentObject var router: Router
    @StateObject var postCommentsViewModel: PostCommentsViewModel
    @ObservedObject var commentMediaBottomSheetViewModel: ImportMediaBottomSheetViewModel
    
    
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
            
            CommentsView(postCommentsViewModel: postCommentsViewModel)
            
            
            appDIContainer.createAddCommentView(postCommentsViewModel: postCommentsViewModel, commentMediaBottomSheetViewModel: commentMediaBottomSheetViewModel)
        }
        .sheet(isPresented: Binding<Bool>(
            get: { router.activeSheet == .importMediaComment },
            set: { if !$0 { router.activeSheet = nil } }
        )) {
            appDIContainer.createImportMediaBottomSheet(importMediaBottomSheetViewModel: commentMediaBottomSheetViewModel)
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
