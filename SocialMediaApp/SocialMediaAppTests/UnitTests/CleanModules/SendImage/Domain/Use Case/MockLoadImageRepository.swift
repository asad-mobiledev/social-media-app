//
//  MockPostsListingRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

class MockLoadImageRepository: ImageRepository {
    var errorToThrow: Error?
    
    func loadImage(url: URL) throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        return FileServiceTestHelper.createImageData()
    }
    
    func loadImage(name: String) throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        return FileServiceTestHelper.createImageData()
    }
}
