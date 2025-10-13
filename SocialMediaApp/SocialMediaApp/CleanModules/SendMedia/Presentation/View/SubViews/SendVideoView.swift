//
//  SendVideoView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI
import AVKit

struct SendVideoView: View {
    @Environment(\.appDIContainer) private var appDIContainer
    let videoURL: URL
    
    var body: some View {
        
        appDIContainer.createVideoPlayerView(videoURL: videoURL)
            .frame(width: 150, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
    SendVideoView(videoURL: videoURL)
}
