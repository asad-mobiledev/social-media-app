//
//  MockSendMediaUseCase.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
@testable import SocialMediaApp

class MockSendMediaUseCase: SendMediaUseCase {
    var errorToThrow: Error?
    
    func sendMedia(mediaType: MediaType, mediaURL: URL?) async throws -> PostEntity {
        if let error = errorToThrow {
            throw error
        }
        return PostCommentsViewModelTestsHelper.createPostEntity()
    }
}
