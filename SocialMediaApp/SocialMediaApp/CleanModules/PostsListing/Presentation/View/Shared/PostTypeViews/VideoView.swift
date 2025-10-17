//
//  VideoView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct VideoView: View {
    @Environment(\.appDIContainer) private var appDIContainer
    let videoName: String
    
    var body: some View {
        appDIContainer.createVideoPlayerView(resourceName: videoName)
            .frame(height: 250)
            .clipShape(.rect())
    }
}

#Preview {
//    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
//    VideoView(videoURL: videoURL)
}
