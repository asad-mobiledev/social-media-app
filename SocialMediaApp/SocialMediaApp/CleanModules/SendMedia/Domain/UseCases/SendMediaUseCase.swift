//
//  SendMediaUseCase.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 16/09/2025.
//

import Foundation
import UIKit

protocol SendMediaUseCase {
    func sendMedia(mediaType: MediaType, mediaURL: URL?) async throws -> PostEntity
}


class DefaultSendMediaUseCase: SendMediaUseCase {
    private let repository: PostsListingRepository
    
    init(repository: PostsListingRepository) {
        self.repository = repository
    }
    
    func sendMedia(mediaType: MediaType, mediaURL: URL?) async throws -> PostEntity {
        let postDTO = try await repository.createPost(mediaType: mediaType, mediaURL: mediaURL)
        return postDTO.toEntity()
    }
}
