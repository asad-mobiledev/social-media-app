//
//  VideoPlayerView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 19/09/2025.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @StateObject var videoViewModel: VideoPlayerViewModel
    
    var body: some View {
        VideoPlayer(player: videoViewModel.player)
            .onAppear {
                videoViewModel.load()
                videoViewModel.play()
            }
            .onDisappear {
                videoViewModel.pause()
            }
    }
}

#Preview {
//    VideoPlayerView()
}
