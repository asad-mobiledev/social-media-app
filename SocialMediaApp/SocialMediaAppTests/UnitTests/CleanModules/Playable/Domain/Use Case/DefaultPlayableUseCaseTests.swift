//
//  DefaultPostsListingUseCaseTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultPlayableUseCaseTests {
    @Test(.tags(.usecase, .unit))
    func testProtocolConformance() async throws {
        let mockPlayableRepository = MockPlayableRepository()
        let defaultPlayableUseCase = DefaultPlayableUseCase(playableRepository: mockPlayableRepository)
        
        #expect(defaultPlayableUseCase is PlayableUseCase)
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadFileSuccess() async throws {
        let mockPlayableRepository = MockPlayableRepository()
        let defaultPlayableUseCase = DefaultPlayableUseCase(playableRepository: mockPlayableRepository)
        
        let url = try await defaultPlayableUseCase.load(name: "image.png", mediaType: MediaType.image)
        
        #expect(url != nil)
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadFileFailure() async throws {
        let mockPlayableRepository = MockPlayableRepository()
        mockPlayableRepository.returnNilURL = true
        let defaultPlayableUseCase = DefaultPlayableUseCase(playableRepository: mockPlayableRepository)
        
        let url = try await defaultPlayableUseCase.load(name: "image.png", mediaType: MediaType.image)
        
        #expect(url == nil)
    }
}
