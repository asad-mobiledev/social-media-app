//
//  DefaultLoadImageRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 17/09/2025.
//

import Foundation

class DefaultImageRepository: ImageRepository {
    let fileService: FileService
    
    init(fileService: FileService) {
        self.fileService = fileService
    }
    
    func loadImage(url: URL) throws -> Data {
        try fileService.getData(from: url)
    }
    
    func loadImage(name: String) throws -> Data {
        try fileService.getDataOf(fileName:name, folder: MediaType.image.rawValue, directory: .documents)
    }
}
