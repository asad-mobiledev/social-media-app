//
//  AudioPost.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI
import AVKit

struct AudioPost: View {
    @Environment(\.appDIContainer) private var appDIContainer
    let post: PostEntity
    
    var body: some View {
        VStack {
            appDIContainer.createAudioPlayerView(resourceName: post.mediaName)
                .padding()
            
            appDIContainer.createCommentsCountAndButtonView(post:post)
        }
        .background(Color.secondary)
    }
        
}

#Preview {
//    let audioURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
//    AudioPost(audioURL: audioURL)
}
