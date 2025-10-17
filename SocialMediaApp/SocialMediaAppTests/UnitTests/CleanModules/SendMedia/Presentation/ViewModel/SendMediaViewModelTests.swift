//
//  SendMediaViewModelTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
import Combine
import Testing
@testable import SocialMediaApp

struct SendMediaViewModelTests {
    @Test(.tags(.viewmodel, .unit))
    func testInitialization() async throws {
        let mockSendMediaUseCase = MockSendMediaUseCase()
        let viewModel = SendMediaViewModel(sendMediaUseCase: mockSendMediaUseCase, router: Router())
        
        #expect(viewModel.errorMessage == "")
        #expect(viewModel.isLoading == false)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testPostSuccess() async throws {
        let mockSendMediaUseCase = MockSendMediaUseCase()
        let viewModel = SendMediaViewModel(sendMediaUseCase: mockSendMediaUseCase, router: Router())
        
        viewModel.post(mediaType: .image, mediaURL: nil)
        
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        #expect(viewModel.errorMessage == "")
        #expect(viewModel.isLoading == false)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testPostFailure() async throws {
        let mockSendMediaUseCase = MockSendMediaUseCase()
        mockSendMediaUseCase.errorToThrow = CustomError.message("mock error")
        let viewModel = SendMediaViewModel(sendMediaUseCase: mockSendMediaUseCase, router: Router())
        
        viewModel.post(mediaType: .image, mediaURL: nil)
        
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        #expect(!viewModel.errorMessage.isEmpty)
        #expect(viewModel.isLoading == false)
    }
}
