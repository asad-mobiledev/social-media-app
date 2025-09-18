//
//  DefaultAudioVideoRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 18/09/2025.
//

import Foundation

class DefaultPlayableRepository: PlayableRepository {
    
    let fileService: FileService
    
    init(fileService: FileService) {
        self.fileService = fileService
    }
    
    func load(name: String, mediaType: MediaType) -> URL? {
        fileService.getFileURL(name: name, folder: mediaType.rawValue, directory: .documents)
    }
}
