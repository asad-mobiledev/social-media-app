//
//  PostsRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

import Foundation
import UIKit

protocol PostsListingRepository {
    func getPosts(limit: Int, startAt: String?) async throws -> [PostDTO]
    func createPost(mediaType: MediaType, mediaURL: URL?) async throws
}
