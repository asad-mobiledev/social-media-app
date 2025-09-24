//
//  AudioPlayerModule.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 18/09/2025.
//

import Foundation

class PlayableModule {
    private let fileService: FileService
    
    init(fileService: FileService) {
        self.fileService = fileService
    }
    
    func generateSendAudioView(audioURL: URL) -> SendAudioView {
        return SendAudioView(audioURL: audioURL)
    }
    func generateAudioPlayerView(resourceName: String? = nil, audioURL: URL? = nil) -> AudioPlayerView {
        AudioPlayerView(audioViewModel: generateAudioViewModel(resourceName: resourceName, audioURL: audioURL))
    }
    
    func generateVideoPlayerView(resourceName: String? = nil, videoURL: URL? = nil) -> VideoPlayerView {
        VideoPlayerView(videoViewModel: generateVideoPlayerViewModel(resourceName: resourceName, videoURL: videoURL, playableUseCase: generatePlayableUseCase()))
    }
    
    
    private func generateSendAudioViewModel(audioURL: URL) -> AudioViewModel {
        generateAudioViewModel(audioURL: audioURL)
    }
    private func generateAudioViewModel(resourceName: String? = nil, audioURL: URL? = nil, playableUseCase: PlayableUseCase? = nil) -> AudioViewModel {
        AudioViewModel(playableUseCase: generatePlayableUseCase(), audioURL: audioURL, resourceName: resourceName)
    }
    
    
    private func generateVideoPlayerViewModel(resourceName: String? = nil, videoURL: URL? = nil, playableUseCase: PlayableUseCase? = nil) -> VideoPlayerViewModel {
        VideoPlayerViewModel(playableUseCase: playableUseCase, videoURL: videoURL, resourceName: resourceName)
    }
    
    
    private func generatePlayableUseCase() -> PlayableUseCase {
        DefaultPlayableUseCase(playableRepository: generatePlayableRepository())
    }
    private func generatePlayableRepository() -> PlayableRepository {
        DefaultPlayableRepository(fileService: fileService)
    }
}
