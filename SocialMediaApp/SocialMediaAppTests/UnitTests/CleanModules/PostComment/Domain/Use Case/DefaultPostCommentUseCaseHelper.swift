//
//  DefaultPostsListingUseCaseHelper.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultPostCommentUseCaseHelper {
    static func createMockCommentAndPostDTOTuple() -> (CommentDTO, PostDTO?) {
        (CommentDTO(id: "00464942-C302-4FAB-A49E-A9732B4655DD", postId: "7321CFC0-35FF-479D-BF1B-07DED1BCA06C", parentCommentId: "D8B97DCB-FC5E-4DD1-8FDF-4FA7A79D6823", text: "Asad2", type: "text", mediaName: nil, createdAt: "2025-10-06T13:03:32.611Z", replyCount: nil, depth: "2", parentCommentDepth: "1"), PostDTO(postType: "image", mediaName: "test.png", date: "2025-01-01", commentsCount: "0"))
    }
    static func createMockCommentsDTO() -> [CommentDTO] {
        [CommentDTO(id: "00464942-C302-4FAB-A49E-A9732B4655DD", postId: "7321CFC0-35FF-479D-BF1B-07DED1BCA06C", parentCommentId: "D8B97DCB-FC5E-4DD1-8FDF-4FA7A79D6823", text: "Asad2", type: "text", mediaName: nil, createdAt: "2025-10-06T13:03:32.611Z", replyCount: nil, depth: "2", parentCommentDepth: "1")]
    }
}
