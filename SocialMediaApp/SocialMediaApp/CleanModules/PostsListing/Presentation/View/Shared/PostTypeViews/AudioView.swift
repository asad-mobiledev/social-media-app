//
//  AudioView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct AudioView: View {
    @Environment(\.appDIContainer) private var appDIContainer
    var resourceName: String?
    
    var body: some View {
        appDIContainer.createAudioPlayerView()
            .padding(.horizontal, 10)
    }
}

#Preview {
//    let audioURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
//    AudioView(audioURL: audioURL)
}
