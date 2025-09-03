//
//  AudioComment.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI
import AVKit

struct AudioComment: View {
    @State private var audioProgress = 0.3
    let videoURL: URL
    let depth: Int
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Button(action: {
                    print("Play Audio")
                }) {
                    Image(systemName: false ? Images.pause : Images.play)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.purple)
                }
                Slider(value: $audioProgress, in: 0...1)
                    .accentColor(Color.primary)
                    .frame(width: 130)
                Text("01:00")
                    .foregroundStyle(Color.primary)
                    .font(.body)
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
        
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}

#Preview {
    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
    AudioComment(videoURL: videoURL, depth: 1)
}
