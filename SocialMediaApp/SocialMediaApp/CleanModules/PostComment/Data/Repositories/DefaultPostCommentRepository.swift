//
//  DefaultPostCommentRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 26/09/2025.
//

import Foundation
import UIKit
import SwiftData

class DefaultPostCommentRepository: PostCommentRepository {
    
    private let filesRespository: FileService
    private let networkRepository: NetworkRepository
    private let databaseService: DatabaseService
    
    init(filesRepository: FileService, networkRepository: NetworkRepository, databaseService: DatabaseService) {
        self.filesRespository = filesRepository
        self.networkRepository = networkRepository
        self.databaseService = databaseService
    }
    
    func addComment(postId: String, mediaAttachement: MediaAttachment?, commentText: String?, parentCommentId: String? = nil, parentCommentDepth: String? = nil) async throws -> (CommentDTO, PostDTO?) {
        var fileName: String? = nil
        if let url = mediaAttachement?.url {
            fileName = try filesRespository.save(mediaType: mediaAttachement!.mediaType, mediaURL: url)
        }
        if commentText?.isEmpty == true && fileName == nil {
            throw CustomError.message(AppText.invalidComment)
        }
        return try await networkRepository.addComment(postId: postId, mediaAttachement: mediaAttachement, fileName: fileName, commentText: commentText, parentCommentId: parentCommentId, parentCommentDepth: parentCommentDepth)
    }
    
    func getComments(postId: String, limit: Int, startAt: String?, parentCommentId: String?) async throws -> [CommentDTO] {
        var comments: [CommentDTO] = []
        do {
            comments = try await networkRepository.getComments(postId: postId, limit: limit, startAt: startAt, parentCommentId: parentCommentId)
            do {
                if startAt == nil {
                    do {
                        try await databaseService.deleteAll(of: PostCommentModel.self)
                    } catch {
                        print("Failed deleting Database records \(#function)")
                        return comments
                    }
                }
                try await databaseService.batchSave(items: comments.map { $0.toCommentModel() })
            } catch {
                print("Failed saving to Database \(#function)")
            }
        } catch {
            var predicate: Predicate<PostCommentModel>? = nil
            if let dateString = startAt {
                predicate = #Predicate { $0.createdAt < dateString }
            }
            var descriptor = FetchDescriptor<PostCommentModel>(
                predicate: predicate,
                sortBy: [SortDescriptor(\PostCommentModel.createdAt, order: .reverse)]
            )
            descriptor.fetchLimit = limit
            let commentModels = try await databaseService.fetch(descriptor: descriptor)
            comments = commentModels.map { CommentDTO(from: $0) }
        }
        return comments
    }
}
