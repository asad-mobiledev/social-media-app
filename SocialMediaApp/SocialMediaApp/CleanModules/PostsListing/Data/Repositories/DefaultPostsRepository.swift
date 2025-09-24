//
//  DefaultPostsRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

import Foundation
import UIKit
import SwiftData

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
    func createPost(mediaType: MediaType, mediaURL: URL?) async throws -> PostDTO {
        let fileName = try filesRespository.save(mediaType: mediaType, mediaURL: mediaURL, directory: .documents)
        let post = try await networkRepository.createPost(mediaType: mediaType, mediaName: fileName)
        do {
            try await databaseService.save(item: post.toPostModel())
        } catch {
            print("Failed saving to Database \(#function)")
        }
        return post
    }
    
    func getPosts(limit: Int, startAt: String?) async throws -> [PostDTO] {
        var posts: [PostDTO] = []
        do {
            posts = try await networkRepository.getPosts(limit: limit, startAt: startAt)
            do {
                if startAt == nil {
                    do {
                        try await databaseService.deleteAll(of: PostModel.self)
                    } catch {
                        print("Failed deleting Database records \(#function)")
                        return posts
                    }
                }
                try await databaseService.batchSave(items: posts.map { $0.toPostModel() })
            } catch {
                print("Failed saving to Database \(#function)")
            }
        } catch {
            var predicate: Predicate<PostModel>? = nil
            if let dateString = startAt {
                predicate = #Predicate { $0.date < dateString }
            }
            var descriptor = FetchDescriptor<PostModel>(
                predicate: predicate,
                sortBy: [SortDescriptor(\PostModel.date, order: .reverse)]
            )
            descriptor.fetchLimit = limit
            let postModels = try await databaseService.fetch(descriptor: descriptor)
            posts = postModels.map { PostDTO(from: $0) }
        }
        return posts
    }
}
