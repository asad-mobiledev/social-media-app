//
//  AudioPost.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI
import AVKit

struct AudioPost: View {
    let audioURL: URL
    
    var body: some View {
        VStack {
            AudioView(audioURL: audioURL)
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
