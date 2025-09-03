//
//  AudioView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct AudioView: View {
    @State private var audioProgress = 0.3
    let audioURL: URL
    
    var body: some View {
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
            
            Text("01:00")
                .foregroundStyle(Color.primary)
                .font(.body)
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    let audioURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
    AudioView(audioURL: audioURL)
}
