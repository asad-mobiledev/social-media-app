//
//  SendAudioViewModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 10/09/2025.
//

import Foundation
import AVKit

class SendAudioViewModel: ObservableObject {
    @Published var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var audioProgress: Double = 0
    @Published var currentTimeString = "00:00"
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    let audioURL: URL
    
    init(audioURL: URL) {
        self.audioURL = audioURL
        setupAudioPlayer()
    }
    
    func setupAudioPlayer() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Failed to load audio: \(error)")
        }
    }
    
    func togglePlayback() {
        guard let player = audioPlayer else { return }
        
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        
        isPlaying.toggle()
    }
    
    func updateProgress() {
        guard let player = audioPlayer else { return }
        
        let currentTime = player.currentTime
        let duration = player.duration
        
        if duration > 0 {
            audioProgress = currentTime / duration
            currentTimeString = formatTime(currentTime)
        }
    }
    
    func sliderEditingChanged(_ editing: Bool) {
        guard let player = audioPlayer, !editing else { return }
        let newTime = audioProgress * player.duration
        player.currentTime = newTime
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
