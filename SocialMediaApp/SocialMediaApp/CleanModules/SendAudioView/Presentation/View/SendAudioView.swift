//
//  SendAudioView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//
import SwiftUI
import AVKit

struct SendAudioView: View {
    @Environment(\.appDIContainer) private var appDIContainer
    var audioURL: URL
    
    var body: some View {
        appDIContainer.createAudioPlayerView(audioURL: audioURL)
        .frame(width: 200)
        .padding()
        .background(Color.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}


#Preview {
    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
//    SendAudioView(audioURL: videoURL)
}
