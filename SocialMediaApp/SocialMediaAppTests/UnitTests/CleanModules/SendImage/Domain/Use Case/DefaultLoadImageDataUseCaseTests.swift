//
//  DefaultPostsListingUseCaseTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultLoadImageDataUseCaseTests {
    @Test(.tags(.usecase, .unit))
    func testProtocolConformance() async throws {
        let mockLoadImageRepository = MockLoadImageRepository()
        let defaultLoadImageDataUseCase = DefaultLoadImageDataUseCase(loadImageRepository: mockLoadImageRepository)
        
        #expect(defaultLoadImageDataUseCase is ImageUseCase)
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadImageByNameSuccess() async throws {
        let mockLoadImageRepository = MockLoadImageRepository()
        let defaultLoadImageDataUseCase = DefaultLoadImageDataUseCase(loadImageRepository: mockLoadImageRepository)
        
        let _ = FileServiceTestHelper.createTestImageFile(fileName: "image.png", folderName: "images", directory: .documents)
        
        let data = try defaultLoadImageDataUseCase.loadImage(name: "image.png")
        
        #expect(data != nil)
        #expect(data.count > 0)
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadImageByNameFailure() async throws {
        let mockLoadImageRepository = MockLoadImageRepository()
        mockLoadImageRepository.errorToThrow = CustomError.message("Mock error")
        let defaultLoadImageDataUseCase = DefaultLoadImageDataUseCase(loadImageRepository: mockLoadImageRepository)
        
        let _ = FileServiceTestHelper.createTestImageFile(fileName: "image.png", folderName: "images", directory: .documents)
        
        #expect(throws: CustomError.self) {
            let data = try defaultLoadImageDataUseCase.loadImage(name: "image.png")
        }
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadImageByURLSuccess() async throws {
        let mockLoadImageRepository = MockLoadImageRepository()
        let defaultLoadImageDataUseCase = DefaultLoadImageDataUseCase(loadImageRepository: mockLoadImageRepository)
        
        let url = FileServiceTestHelper.createTestImageFile(fileName: "image.png", folderName: "images", directory: .documents)!
        
        let data = try defaultLoadImageDataUseCase.loadImage(url: url)
        
        #expect(data != nil)
        #expect(data.count > 0)
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadImageByURLFailure() async throws {
        let mockLoadImageRepository = MockLoadImageRepository()
        mockLoadImageRepository.errorToThrow = CustomError.message("Mock error")
        let defaultLoadImageDataUseCase = DefaultLoadImageDataUseCase(loadImageRepository: mockLoadImageRepository)
        
        let url = FileServiceTestHelper.createTestImageFile(fileName: "image.png", folderName: "images", directory: .documents)!
        
        #expect(throws: CustomError.self) {
            let data = try defaultLoadImageDataUseCase.loadImage(url: url)
        }
    }
}
