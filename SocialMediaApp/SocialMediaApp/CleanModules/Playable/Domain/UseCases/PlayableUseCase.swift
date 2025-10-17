//
//  AudioPlayerUseCase.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 18/09/2025.
//

import Foundation

protocol PlayableUseCase {
    func load(name: String, mediaType: MediaType) -> URL?
}

class DefaultPlayableUseCase: PlayableUseCase {
    let playableRepository: PlayableRepository
    
    init(playableRepository: PlayableRepository) {
        self.playableRepository = playableRepository
    }
    
    func load(name: String, mediaType: MediaType) -> URL? {
        playableRepository.load(name: name, mediaType: mediaType)
    }
}


