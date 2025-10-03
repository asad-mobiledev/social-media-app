//
//  VideoPost.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI

struct VideoPost: View {
    @Environment(\.appDIContainer) private var appDIContainer
    let post: PostEntity
    
    var body: some View {
        VStack {
            appDIContainer.createVideoView(videoName: post.mediaName)
            appDIContainer.createCommentsCountAndButtonView(post:post)
        }
        .background(Color.secondary)
    }
        
}

#Preview {
//    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
//    VideoPost(videoURL: videoURL)
}
