//
//  AudioPlayerViewModelTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
import Combine
import Testing
@testable import SocialMediaApp

struct VideoPlayerViewModelTests {
    @Test(.tags(.viewmodel, .unit))
    func testInitialization() async throws {
        let videoFileURL = FileServiceTestHelper.createTestAudioFile(fileName: "test.mp4", folderName: "test", directory: .documents)
        let viewModel = VideoPlayerViewModel(playableUseCase: nil, videoURL: videoFileURL, resourceName: videoFileURL?.lastPathComponent)
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        #expect(viewModel.videoURL == videoFileURL)
        #expect(viewModel.resourceName == "test.mp4")
        #expect(viewModel.errorMessage == nil)
        
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testPublishedPropertiesAreObservable() async throws {
        var videoURLs: [URL] = []
        var cancellables = Set<AnyCancellable>()
        let videoFileURL = FileServiceTestHelper.createTestAudioFile(fileName: "test.mp4", folderName: "test", directory: .documents)
        let viewModel = VideoPlayerViewModel(playableUseCase: nil, videoURL: videoFileURL, resourceName: videoFileURL?.lastPathComponent)
        
        viewModel.$videoURL
            .sink { url in
                videoURLs.append(url!)
            }
            .store(in: &cancellables)
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        #expect(videoURLs.count > 0)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testLoad() async throws {
        var videoURLs: [URL] = []
        var cancellables = Set<AnyCancellable>()
        let videoFileURL = FileServiceTestHelper.createTestAudioFile(fileName: "test.mp4", folderName: "test", directory: .documents)
        let viewModel = VideoPlayerViewModel(playableUseCase: nil, videoURL: videoFileURL, resourceName: videoFileURL?.lastPathComponent)
        
        viewModel.$videoURL
            .sink { url in
                videoURLs.append(url!)
            }
            .store(in: &cancellables)
        viewModel.load()
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        #expect(viewModel.videoURL != nil)
        #expect(viewModel.videoURL == videoURLs.first)
    }
}
