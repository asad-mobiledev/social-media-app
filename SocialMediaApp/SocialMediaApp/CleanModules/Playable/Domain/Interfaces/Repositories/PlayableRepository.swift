//
//  AudioVideoRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 18/09/2025.
//

import Foundation

protocol PlayableRepository {
    func load(name: String, mediaType: MediaType) -> URL?
}
