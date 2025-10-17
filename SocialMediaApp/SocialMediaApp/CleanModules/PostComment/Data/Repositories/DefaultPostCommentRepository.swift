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
        let commentDTO = try await networkRepository.addComment(postId: postId, mediaAttachement: mediaAttachement, fileName: fileName, commentText: commentText, parentCommentId: parentCommentId, parentCommentDepth: parentCommentDepth)
        do {
            try await databaseService.save(item: commentDTO.toCommentModel())
        } catch {
            print("Failed saving to Database \(#function)")
            return (commentDTO, nil)
        }
        
        if let parentId = commentDTO.parentCommentId {
            do {
                let parentComment = try await networkRepository.updateParentCommentsReplyCounts(parentId)
                do {
                    let predicate: Predicate<PostCommentModel> = #Predicate { $0.id == parentId }
                    let descriptor = FetchDescriptor<PostCommentModel>(
                        predicate: predicate)
                    try await databaseService.deleteAll(of: PostCommentModel.self, descriptor: descriptor)
                    try await databaseService.save(item: parentComment.toCommentModel())
                } catch {
                    print("Failed deleting Database records \(#function)")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        var post: PostDTO?
        do {
            post = try await networkRepository.incrementPostCommentsCount(postId: postId)
            do {
                let predicate: Predicate<PostModel> = #Predicate { $0.id == postId}
                let descriptor = FetchDescriptor<PostModel>(
                    predicate: predicate)
                try await databaseService.deleteAll(of: PostModel.self, descriptor: descriptor)
                try await databaseService.save(item: post!.toPostModel())
            } catch {
                print("Failed deleting Database records \(#function)")
            }
        } catch {
            print(error.localizedDescription)
        }
        return (commentDTO, post)
    }
    
    func getComments(postId: String, limit: Int, startAt: String?, parentCommentId: String?) async throws -> [CommentDTO] {
        var comments: [CommentDTO] = []
        do {
            comments = try await networkRepository.getComments(postId: postId, limit: limit, startAt: startAt, parentCommentId: parentCommentId)
            do {
                if startAt == nil {
                    do {
                        let predicate = getFetchCommentsSwiftDataPredicate(nil, parentCommentId, postId)
                       let descriptor = FetchDescriptor<PostCommentModel>(
                            predicate: predicate)
                        try await databaseService.deleteAll(of: PostCommentModel.self, descriptor: descriptor)
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
            let predicate = getFetchCommentsSwiftDataPredicate(startAt, parentCommentId, postId)
            var descriptor = FetchDescriptor<PostCommentModel>(
                predicate: predicate,
                sortBy: [SortDescriptor(\PostCommentModel.createdAt, order: .reverse)]
            )
            if parentCommentId == nil {
                descriptor.fetchLimit = limit
            }
            let commentModels = try await databaseService.fetch(descriptor: descriptor)
            comments = commentModels.map { CommentDTO(from: $0) }
        }
        return comments
    }
    
    private func getFetchCommentsSwiftDataPredicate(_ startAt: String?, _ parentCommentId: String?, _ postId: String) -> Predicate<PostCommentModel>? {
        if let parentId = parentCommentId {
            return #Predicate { $0.postId == postId && $0.parentCommentId == parentId }
        } else {
            if let startDate = startAt {
                return #Predicate { $0.createdAt < startDate && $0.postId == postId && $0.parentCommentId == nil }
            } else {
                return #Predicate { $0.postId == postId && $0.parentCommentId == nil }
            }
        }
    }
}
