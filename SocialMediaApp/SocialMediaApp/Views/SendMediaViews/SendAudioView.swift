//
//  SendAudioView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//
import SwiftUI
import AVKit

struct SendAudioView: View {
    @StateObject private var viewModel: SendAudioViewModel
    private var audioProgressBinding: Binding<Double> {
        Binding(
            get: { viewModel.audioProgress },
            set: { newValue in viewModel.audioProgress = newValue }
        )
    }
    
    init(audioURL: URL) {
        _viewModel = StateObject(wrappedValue: SendAudioViewModel(audioURL: audioURL))
    }
    
    var body: some View {
        
        HStack(spacing: 3) {
            Button(action: viewModel.togglePlayback) {
                Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.purple)
            }
            .padding(.trailing, 3)
            Slider(value: audioProgressBinding, in: 0...1, onEditingChanged: viewModel.sliderEditingChanged)
                .accentColor(.purple)
            
            Text(viewModel.currentTimeString)
                .foregroundStyle(Color.primary)
                .font(.caption)
        }
        .frame(width: 200)
        .padding()
        .background(Color.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .onAppear {
            viewModel.setupAudioPlayer()
        }
        .onDisappear {
            viewModel.audioPlayer?.stop()
        }
        .onReceive(viewModel.timer) { _ in
            viewModel.updateProgress()
        }
    }
}


#Preview {
    let videoURL = Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!
    SendAudioView(audioURL: videoURL)
}
