//
//  SendMediaRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 16/09/2025.
//

import UIKit

protocol SendMediaRepository {
    func createPost(mediaType: MediaType, image: UIImage?, mediaURL: URL?, imageExtension: String) async throws
}
