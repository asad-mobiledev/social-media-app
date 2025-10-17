//
//  SendAudioViewModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 10/09/2025.
//

import Foundation
import AVKit
import Combine

class AudioViewModel: ObservableObject {
    @Published var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var audioProgress: Double = 0
    @Published var currentTimeString = "00:00"
    @Published var audioURL: URL?
    @Published var resourceName: String?
    @Published var errorMessage: String?
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    let playableUseCase: PlayableUseCase?
    private var cancellables = Set<AnyCancellable>()
    
    init(playableUseCase: PlayableUseCase? = nil, audioURL: URL? = nil, resourceName: String? = nil) {
        self.playableUseCase = playableUseCase
        self.audioURL = audioURL
        self.resourceName = resourceName
        
         $audioURL
            .sink {[weak self] url in
                guard url != nil else { return }
                guard let self = self else { return }
                
                if url != nil {
                    self.setupAudioPlayer(url: url!)
                }
            }
            .store(in: &cancellables)
    }
    
    func setupAudioPlayer(url: URL) {
        do {
            if url.startAccessingSecurityScopedResource() {
                defer { url.stopAccessingSecurityScopedResource() }
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
            } else {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
            }
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
        guard isPlaying, let player = audioPlayer else { return }
        
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
    
    func reset() {
        isPlaying = false
        currentTimeString = "00:00"
        audioProgress = 0
    }
    
    func load() {
        if let url = self.audioURL {
            self.audioURL = url
        } else {
            guard playableUseCase != nil else { return }
            guard resourceName != nil else { return }
            guard let url = playableUseCase!.load(name: resourceName!, mediaType: MediaType.audio) else {
                errorMessage = AppText.failLoadResourceURL
                return
            }
            self.audioURL = url
        }
    }
}
