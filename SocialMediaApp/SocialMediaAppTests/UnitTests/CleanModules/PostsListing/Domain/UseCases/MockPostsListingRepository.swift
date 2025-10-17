//
//  MockPostsListingRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

class MockPostsListingRepository: PostsListingRepository {
    var errorToThrow: Error?
    
    func getPosts(limit: Int, startAt: String?) async throws -> [PostDTO] {
        if let error = errorToThrow {
            throw error
        }
        
        return DefaultPostsListingUseCaseHelper.createMockPostsDTO()
    }
    
    func createPost(mediaType: MediaType, mediaURL: URL?) async throws -> PostDTO {
        if let error = errorToThrow {
            throw error
        }
        
        return DefaultPostsListingUseCaseHelper.createMockPostDTO()
    }
}
