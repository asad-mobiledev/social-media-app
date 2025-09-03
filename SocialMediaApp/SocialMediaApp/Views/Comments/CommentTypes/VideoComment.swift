//
//  VideoComment.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI
import AVKit

struct VideoComment: View {
    @State private var player: AVPlayer?
    let videoURL: URL
    let depth: Int
    
    var body: some View {
        VStack(alignment: .trailing) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 150, height: 150)
                .overlay(Text("Loading..."))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    VideoPlayer(player: player)
                        .frame(maxWidth: 150, maxHeight: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            
            if depth < 2 {
                Button(AppText.reply) {
                    print("Reply Pressed")
                }
                .font(.system(size: 12))
                .foregroundStyle(Color.black)
                .padding(.trailing, 5)
            }
        }
        .onAppear {
            if player == nil {
                print("VideoComment appeared at depth \(depth)")
                player = AVPlayer(url: videoURL)
                player?.play()
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        
    }
}

#Preview {
    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
    VideoComment(videoURL: videoURL, depth: 1)
}
