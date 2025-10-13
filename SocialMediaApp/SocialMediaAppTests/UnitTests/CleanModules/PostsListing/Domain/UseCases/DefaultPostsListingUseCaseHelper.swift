//
//  DefaultPostsListingUseCaseHelper.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultPostsListingUseCaseHelper {
    static func createMockPostDTO() -> PostDTO {
        PostDTO(postType: "image", mediaName: "test.png", date: "2025-01-01", commentsCount: "0")
    }
    static func createMockPostsDTO() -> [PostDTO] {
        [PostDTO(postType: "image", mediaName: "test.png", date: "2025-01-01", commentsCount: "0")]
    }
}
