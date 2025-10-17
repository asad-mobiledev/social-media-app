//
//  AudioViewModelTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//
import Foundation
import Combine
import Testing
@testable import SocialMediaApp

struct AudioViewModelTests {
    @Test(.tags(.viewmodel, .unit))
    func testInitialization() async throws {
        let audioFileURL = FileServiceTestHelper.createTestAudioFile(fileName: "test.mp3", folderName: "test", directory: .documents)
        let viewModel = AudioViewModel(playableUseCase: nil, audioURL: audioFileURL, resourceName: audioFileURL?.lastPathComponent)
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        #expect(viewModel.isPlaying == false)
        #expect(viewModel.audioProgress == 0)
        #expect(viewModel.currentTimeString == "00:00")
        #expect(viewModel.audioURL == audioFileURL)
        #expect(viewModel.resourceName == audioFileURL?.lastPathComponent)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testPublishedPropertiesAreObservable() async throws {
        var audioURLs: [URL] = []
        var cancellables = Set<AnyCancellable>()
        let audioFileURL = FileServiceTestHelper.createTestAudioFile(fileName: "test.mp3", folderName: "test", directory: .documents)
        let viewModel = AudioViewModel(playableUseCase: nil, audioURL: audioFileURL, resourceName: audioFileURL?.lastPathComponent)
        
        viewModel.$audioURL
            .sink { url in
                audioURLs.append(url!)
            }
            .store(in: &cancellables)
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        #expect(audioURLs.count > 0)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testFormatTime() async throws {
        var cancellables = Set<AnyCancellable>()
        let audioFileURL = FileServiceTestHelper.createTestAudioFile(fileName: "test.mp3", folderName: "test", directory: .documents)
        let viewModel = AudioViewModel(playableUseCase: nil, audioURL: audioFileURL, resourceName: audioFileURL?.lastPathComponent)
        
        let time = viewModel.formatTime(61)
        
        #expect(time == "01:01")
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testLoad() async throws {
        var audioURLs: [URL] = []
        var cancellables = Set<AnyCancellable>()
        let audioFileURL = FileServiceTestHelper.createTestAudioFile(fileName: "test.mp3", folderName: "test", directory: .documents)
        let viewModel = AudioViewModel(playableUseCase: nil, audioURL: audioFileURL, resourceName: audioFileURL?.lastPathComponent)
        
        viewModel.$audioURL
            .sink { url in
                audioURLs.append(url!)
            }
            .store(in: &cancellables)
        viewModel.load()
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        #expect(viewModel.audioURL != nil)
        #expect(viewModel.audioURL == audioURLs.first)
    }
}
