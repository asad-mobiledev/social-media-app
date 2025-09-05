//
//  SendVideoView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI
import AVKit

struct SendVideoView: View {
    @State private var player: AVPlayer?
    let videoURL: URL
    
    var body: some View {
        
        VideoPlayer(player: player)
            .frame(width: 150, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .onAppear {
                player = AVPlayer(url: videoURL)
                player?.play()
            }
    }
}

#Preview {
    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
    SendVideoView(videoURL: videoURL)
}
