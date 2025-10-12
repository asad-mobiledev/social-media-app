//
//  MockDataTransferService.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 10/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

class MockDataTransferService: DataTransferService {
    var errorToThrow: Error?
    var dataToReturn: PostDTO?
    var receivedRequest: NetworkRequest?
    var requestFetchCallCount = 0
    var requestPostCallCount = 0
    var postsToReturn: [FirestorePostsDocumentWrapper] = []
    var postToReturn: FirestorePostsDocumentWrapper?
    var commentsToReturn: [FirestoreCommentssDocumentWrapper] = []
    var commentToReturn: FirestoreCommentssDocumentWrapper?
    var commentDocumentToReturn: FirestoreCommentDocument?
    
    func request<T>(request: NetworkRequest) async throws -> T where T : Decodable {
        requestFetchCallCount += 1
        receivedRequest = request
        
        if let error = errorToThrow {
            throw error
        }
        if T.self == FirestorePostsDocumentWrapper.self {
            return postToReturn as! T
        } else if T.self == [FirestorePostsDocumentWrapper].self {
            return postsToReturn as! T
        }
        else if T.self == FirestoreCommentssDocumentWrapper.self {
            return commentToReturn as! T
        } else if T.self == [FirestoreCommentssDocumentWrapper].self {
            return commentsToReturn as! T
        }
        
        throw NetworkError.unableToDecode
    }
    
    func request(request: NetworkRequest) async throws {
        requestPostCallCount += 1
        
        if let error = errorToThrow {
            throw error
        }
    }
}


