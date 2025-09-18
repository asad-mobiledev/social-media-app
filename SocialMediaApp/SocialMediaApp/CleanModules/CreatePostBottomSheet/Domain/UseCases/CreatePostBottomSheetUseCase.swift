//
//  CreatePostBottomSheetUseCase.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//
import Foundation
import UIKit

protocol CreatePostBottomSheetUseCase {
    func createPost(mediaType: MediaType, image: UIImage?, mediaURL: URL?, imageExtension: String) async throws
}

final class DefaultCreatePostBottomSheetUseCase: CreatePostBottomSheetUseCase {
    private let repository: PostsListingRepository
    
    init(repository: PostsListingRepository) {
        self.repository = repository
    }
    
    func createPost(mediaType: MediaType, image: UIImage?, mediaURL: URL?, imageExtension: String) async throws {
        try await repository.createPost(mediaType: mediaType, mediaURL: mediaURL)
    }
}
