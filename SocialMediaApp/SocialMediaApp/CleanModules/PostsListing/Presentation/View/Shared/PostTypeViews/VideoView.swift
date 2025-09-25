//
//  VideoView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct VideoView: View {
    @Environment(\.appDIContainer) private var appDIContainer
    let fileURL: URL
    
    var body: some View {
        appDIContainer.createVideoPlayerView(videoURL: fileURL)
            .frame(height: 250)
            .clipShape(.rect())
            .overlay(
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 4)
            )
    }
}

#Preview {
//    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
//    VideoView(videoURL: videoURL)
}
