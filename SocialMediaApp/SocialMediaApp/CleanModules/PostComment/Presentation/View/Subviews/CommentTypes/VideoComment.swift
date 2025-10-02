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
    let mediaName: String
    let depth: Int
    
    var body: some View {
        VStack(alignment: .trailing) {
            appDIContainer.createVideoPlayerView(resourceName: mediaName)
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            if depth < 2 {
                Button(AppText.reply) {
                    print("Reply Pressed")
                }
                .font(.system(size: 12))
                .foregroundStyle(Color.black)
                .padding(.trailing, 5)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        
    }
}

#Preview {
    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
//    VideoComment(videoURL: videoURL, depth: 1)
}
