//
//  VideoPlayerViewModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 19/09/2025.
//

import Foundation
import AVFoundation
import Combine

class VideoPlayerViewModel: ObservableObject {
    @Published var player: AVPlayer?
    @Published var videoURL: URL?
    @Published var resourceName: String?
    @Published var errorMessage: String?
    
    let playableUseCase: PlayableUseCase?
    private var cancellables = Set<AnyCancellable>()
    
    init(playableUseCase: PlayableUseCase? = nil, videoURL: URL? = nil, resourceName: String? = nil) {
        self.playableUseCase = playableUseCase
        self.videoURL = videoURL
        self.resourceName = resourceName
        
         $videoURL
            .sink {[weak self] url in
                guard url != nil else { return }
                guard let self = self else { return }
                
                if url != nil {
                    if url!.startAccessingSecurityScopedResource() {
                        defer { url!.stopAccessingSecurityScopedResource() }
                        player = AVPlayer(url: url!)
                    } else {
                        player = AVPlayer(url: url!)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func load() {
        if let url = self.videoURL {
            self.videoURL = url
        } else {
            guard playableUseCase != nil else { return }
            guard resourceName != nil else { return }
            guard let url = playableUseCase!.load(name: resourceName!, mediaType: MediaType.video) else {
                errorMessage = AppText.failLoadResourceURL
                return
            }
            self.videoURL = url
        }
    }
}
