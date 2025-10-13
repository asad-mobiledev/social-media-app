//
//  MockPostListingUseCase.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

class MockPostListingUseCase: PostsListingUseCase {
    var errorToThrow: Error?
    
    func fetchPosts(limit: Int, startAt: String?) async throws -> [PostEntity] {
        if let error = errorToThrow {
            throw error
        }
        return [PostCommentsViewModelTestsHelper.createPostEntity()]
    }
}
