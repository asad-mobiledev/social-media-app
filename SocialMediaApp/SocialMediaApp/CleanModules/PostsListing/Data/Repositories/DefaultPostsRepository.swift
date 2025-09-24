//
//  DefaultPostsRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

import Foundation
import UIKit

final class DefaultPostsRepository {
    private let filesRespository: FileService
    private let networkRepository: NetworkRepository
    private let databaseService: DatabaseService
    
    init(filesRepository: FileService, networkRepository: NetworkRepository, databaseService: DatabaseService) {
        self.filesRespository = filesRepository
        self.networkRepository = networkRepository
        self.databaseService = databaseService
    }
}

extension DefaultPostsRepository: PostsListingRepository {
    func createPost(mediaType: MediaType, mediaURL: URL?) async throws {
        let fileName = try filesRespository.save(mediaType: mediaType, mediaURL: mediaURL, directory: .documents)
        try await networkRepository.createPost(mediaType: mediaType, mediaName: fileName)
    }
    
    func getPosts(limit: Int, startAt: String?) async throws -> [PostDTO] {
        let posts = try await networkRepository.getPosts(limit: limit, startAt: startAt)
        // save posts to DB
        return posts
    }
}
