//
//  VideoView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI
import AVKit

struct VideoView: View {
    @State private var player: AVPlayer?
    let videoURL: URL
    
    var body: some View {
        VideoPlayer(player: player)
            .frame(height: 250)
            .clipShape(.rect())
            .overlay(
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 4)
            )
            .onAppear {
                player = AVPlayer(url: videoURL)
                player?.play()
            }
    }
}

#Preview {
    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
    VideoView(videoURL: videoURL)
}
