//
//  AudioPlayerView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 18/09/2025.
//

import SwiftUI

struct AudioPlayerView: View {
    @StateObject var audioViewModel: AudioViewModel
    private var audioProgressBinding: Binding<Double> {
        Binding(
            get: { audioViewModel.audioProgress },
            set: { newValue in audioViewModel.audioProgress = newValue }
        )
    }
    
    var body: some View {
        HStack(spacing: 3) {
            Button(action: audioViewModel.togglePlayback) {
                Image(systemName: audioViewModel.isPlaying ? Images.pause : Images.play)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.purple)
            }
            .padding(.trailing, 3)
            Slider(value: audioProgressBinding, in: 0...1, onEditingChanged: audioViewModel.sliderEditingChanged)
                .accentColor(.purple)
            
            Text(audioViewModel.currentTimeString)
                .foregroundStyle(Color.primary)
                .font(.caption)
        }
        .onAppear {
            audioViewModel.reset()
            audioViewModel.load()
        }
        .onReceive(audioViewModel.timer) { _ in
            audioViewModel.updateProgress()
        }
    }
}

#Preview {
//    AudioPlayerView()
}
