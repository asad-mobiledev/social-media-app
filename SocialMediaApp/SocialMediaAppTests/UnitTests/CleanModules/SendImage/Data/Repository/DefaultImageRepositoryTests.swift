//
//  DefaultImageRepositoryTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultImageRepositoryTests {
    @Test(.tags(.usecase, .unit))
    func testProtocolConformance() async throws {
        let mockFileService = MockFileService()
        let defaultImageRepository = DefaultImageRepository(fileService: mockFileService)
        
        #expect(defaultImageRepository is ImageRepository)
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadImageByNameSuccess() async throws {
        let mockFileService = MockFileService()
        let defaultImageRepository = DefaultImageRepository(fileService: mockFileService)
        
        let _ = FileServiceTestHelper.createTestImageFile(fileName: "image.png", folderName: "images", directory: .documents)
        
        let data = try defaultImageRepository.loadImage(name: "image.png")
        
        #expect(data != nil)
        #expect(data.count > 0)
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadImageByNameFailure() async throws {
        let mockFileService = MockFileService()
        let defaultImageRepository = DefaultImageRepository(fileService: mockFileService)
        mockFileService.errorToThrow = CustomError.message("Mock error")
        
        let _ = FileServiceTestHelper.createTestImageFile(fileName: "image.png", folderName: "images", directory: .documents)
        
        #expect(throws: CustomError.self) {
            let data = try defaultImageRepository.loadImage(name: "image.png")
        }
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadImageByURLSuccess() async throws {
        let mockFileService = MockFileService()
        let defaultImageRepository = DefaultImageRepository(fileService: mockFileService)
        
        let url = FileServiceTestHelper.createTestImageFile(fileName: "image.png", folderName: "images", directory: .documents)!
        
        let data = try defaultImageRepository.loadImage(url: url)
        
        #expect(data != nil)
        #expect(data.count > 0)
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadImageByURLFailure() async throws {
        let mockFileService = MockFileService()
        let defaultImageRepository = DefaultImageRepository(fileService: mockFileService)
        mockFileService.errorToThrow = CustomError.message("Mock error")
        let url = FileServiceTestHelper.createTestImageFile(fileName: "image.png", folderName: "images", directory: .documents)!
        
        #expect(throws: CustomError.self) {
            let data = try defaultImageRepository.loadImage(url: url)
        }
    }
}

