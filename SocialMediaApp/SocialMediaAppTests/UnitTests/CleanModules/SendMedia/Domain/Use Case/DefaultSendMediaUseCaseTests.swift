//
//  DefaultPostsListingUseCaseTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultSendMediaUseCaseTests {
    @Test(.tags(.usecase, .unit))
    func testProtocolConformance() async throws {
        let mockPostsListingRepository = MockPostsListingRepository()
        let defaultSendMediaUseCase = DefaultSendMediaUseCase(repository: mockPostsListingRepository)
        
        #expect(defaultSendMediaUseCase is SendMediaUseCase)
    }
    
    @Test(.tags(.usecase, .unit))
    func testSendMediaSuccess() async throws {
        let mockPostsListingRepository = MockPostsListingRepository()
        let defaultSendMediaUseCase = DefaultSendMediaUseCase(repository: mockPostsListingRepository)
        let url = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)!
        let postEntity = try await defaultSendMediaUseCase.sendMedia(mediaType: .image, mediaURL: url)
        #expect(postEntity != nil)
        #expect(postEntity.mediaName == "test.png")
    }
    
    @Test(.tags(.usecase, .unit))
    func testSendMediaFailure() async throws {
        let mockPostsListingRepository = MockPostsListingRepository()
        mockPostsListingRepository.errorToThrow = CustomError.message("mock error")
        let defaultSendMediaUseCase = DefaultSendMediaUseCase(repository: mockPostsListingRepository)
        let url = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)!
        
        await #expect(throws: CustomError.self) {
            let postEntity = try await defaultSendMediaUseCase.sendMedia(mediaType: .image, mediaURL: url)
        }
    }
}
