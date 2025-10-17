//
//  MockImageUseCase.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
@testable import SocialMediaApp

class MockImageUseCase: ImageUseCase {
    var errorToThrow: Error?
    
    func loadImage(url: URL) throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        return FileServiceTestHelper.createLargeImageData()
    }
    
    func loadImage(name: String) throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        return FileServiceTestHelper.createLargeImageData()
    }
    
    
}
