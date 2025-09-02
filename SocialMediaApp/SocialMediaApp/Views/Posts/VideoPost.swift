//
//  VideoPost.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI
import AVKit

struct VideoPost: View {
    @State private var player: AVPlayer?
    let videoURL: URL
    
    var body: some View {
        VStack {
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
            HStack {
                Spacer()
                CommentButton()
                    .padding(.trailing, 5)
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
        }
        .background(Color.secondary)
    }
        
}

#Preview {
    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
    VideoPost(videoURL: videoURL)
}
