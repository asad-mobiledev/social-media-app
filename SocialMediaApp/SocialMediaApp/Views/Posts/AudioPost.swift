//
//  AudioPost.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI
import AVKit

struct AudioPost: View {
    @State private var audioProgress = 0.3
    let audioURL: URL
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("Play Audio")
                }) {
                    Image(systemName: false ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.purple)
                }
                Slider(value: $audioProgress, in: 0...1)
                    .padding(.horizontal)
                    .accentColor(.purple)
                
            }
            .padding()
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
    let audioURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
    AudioPost(audioURL: audioURL)
}
