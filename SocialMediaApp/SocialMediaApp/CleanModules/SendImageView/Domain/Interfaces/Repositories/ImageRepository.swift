//
//  LoadImageRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 17/09/2025.
//

import Foundation

protocol ImageRepository {
    func loadImage(url: URL) throws -> Data
    func loadImage(name: String, mediaType: MediaType) throws -> Data
}
