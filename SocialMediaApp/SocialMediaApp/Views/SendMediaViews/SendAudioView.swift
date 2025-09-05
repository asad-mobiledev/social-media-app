//
//  SendAudioView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//
import SwiftUI
import AVKit

struct SendAudioView: View {
    @State private var audioProgress = 0.3
    let videoURL: URL
    
    var body: some View {
        
        HStack(spacing: 3) {
            Button(action: {
                print("Play Audio")
            }) {
                Image(systemName: false ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.purple)
            }
            Slider(value: $audioProgress, in: 0...1)
                .accentColor(.purple)
            
            Text("01:00")
                .foregroundStyle(Color.primary)
                .font(.body)
        }
        .frame(width: 200)
        .padding()
        .background(Color.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
    SendAudioView(videoURL: videoURL)
}
