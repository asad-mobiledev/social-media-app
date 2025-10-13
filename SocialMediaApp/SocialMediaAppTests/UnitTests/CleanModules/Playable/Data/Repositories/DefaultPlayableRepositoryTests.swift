//
//  DefaultPlayableRepositoryTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultPlayableRepositoryTests {
    @Test(.tags(.usecase, .unit))
    func testProtocolConformance() async throws {
        let mockFileService = MockFileService()
        let defaultPlayableRepository = DefaultPlayableRepository(fileService: mockFileService)
        
        #expect(defaultPlayableRepository is PlayableRepository)
        #expect(defaultPlayableRepository.fileService is MockFileService)
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadPlayableURLSuccess() async throws {
        let mockFileService = MockFileService()
        let defaultPlayableRepository = DefaultPlayableRepository(fileService: mockFileService)
        
        let url = FileServiceTestHelper.createTestAudioFile(fileName: "test.mp3", folderName: "test", directory: .documents)
        
        let loadedURL = defaultPlayableRepository.load(name: "test.mp3", mediaType: MediaType.audio)
        
        #expect(loadedURL != nil)
        #expect(loadedURL?.lastPathComponent == "test.mp3")
    }
    
    @Test(.tags(.usecase, .unit))
    func testLoadPlayableURLFailure() async throws {
        let mockFileService = MockFileService()
        let defaultPlayableRepository = DefaultPlayableRepository(fileService: mockFileService)
        
        
        let loadedURL = defaultPlayableRepository.load(name: "", mediaType: MediaType.audio)
        #expect(loadedURL == nil)
    }
}
