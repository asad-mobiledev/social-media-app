//
//  VideoComment.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI
import AVKit

struct VideoComment: View {
    @Environment(\.appDIContainer) private var appDIContainer
    @ObservedObject var postCommentsViewModel: PostCommentsViewModel
    let comment: CommentEntity
    
    var body: some View {
        VStack(alignment: .trailing) {
            appDIContainer.createVideoPlayerView(resourceName: comment.mediaName!)
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            CommentsReplyView(postCommentsViewModel: postCommentsViewModel, comment: comment)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        
    }
}

#Preview {
    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
//    VideoComment(videoURL: videoURL, depth: 1)
}
