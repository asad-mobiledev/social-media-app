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
    let fileURL: URL
    
    var body: some View {
        VStack {
            appDIContainer.createAudioPlayerView(audioURL: fileURL)
                .padding()
            
            HStack {
                Spacer()
                CommentButton(type: .audio)
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
//    let audioURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
//    AudioPost(audioURL: audioURL)
}
