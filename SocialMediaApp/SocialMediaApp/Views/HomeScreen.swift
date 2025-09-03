//
//  HomeScreen.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI

enum PostType {
    case image, video, audio
}

struct HomeScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ImagePost(imageName: "post-image")
                        let url = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
                        VideoPost(videoURL: url)
                        AudioPost(audioURL: url)
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                }
                
                HStack {
                    Button("Create Post") {
                        print("Post created")
                    }
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.primary)
                }
            }
            .navigationTitle(AppText.posts)
        }
    }
}

#Preview {
    HomeScreen()
}
