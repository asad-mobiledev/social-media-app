//
//  VideoPost.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI

struct VideoPost: View {
    let videoName: String
    
    var body: some View {
        VStack {
            VideoView(videoName: videoName)
            HStack {
                Spacer()
                CommentButton(type: .video)
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
//    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
//    VideoPost(videoURL: videoURL)
}
