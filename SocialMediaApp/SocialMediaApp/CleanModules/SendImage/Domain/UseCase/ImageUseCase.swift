//
//  LoadImageDataUseCase.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 17/09/2025.
//

import Foundation

protocol ImageUseCase {
    func loadImage(url: URL) throws -> Data
    func loadImage(name: String) throws -> Data
}

class DefaultLoadImageDataUseCase: ImageUseCase {
    let loadImageRepository: ImageRepository
    
    init(loadImageRepository: ImageRepository) {
        self.loadImageRepository = loadImageRepository
    }
    
    func loadImage(url: URL) throws -> Data {
        try loadImageRepository.loadImage(url: url)
    }
    
    func loadImage(name: String) throws -> Data {
        try loadImageRepository.loadImage(name: name)
    }
}
