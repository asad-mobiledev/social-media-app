//
//  ImageViewModelTests'.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
import Combine
import Testing
@testable import SocialMediaApp

struct ImageViewModelTests {
    @Test(.tags(.viewmodel, .unit))
    func testInitialization() async throws {
        let mockImageUseCase = MockImageUseCase()
        let viewModel = ImageViewModel(loadImageDataUseCase: mockImageUseCase)
        
        #expect(viewModel.image == nil)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func tesFetchImageSuccess() async throws {
        let mockImageUseCase = MockImageUseCase()
        let viewModel = ImageViewModel(loadImageDataUseCase: mockImageUseCase)
        
        await viewModel.fetchImage(imageName: "test.png")
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        #expect(viewModel.image != nil)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func tesFetchImageFailure() async throws {
        let mockImageUseCase = MockImageUseCase()
        mockImageUseCase.errorToThrow = CustomError.message("mock error")
        let viewModel = ImageViewModel(loadImageDataUseCase: mockImageUseCase)
        
        await viewModel.fetchImage(imageName: "test.png")
        try await Task.sleep(nanoseconds: 100_000_000)
        
        #expect(viewModel.image == nil)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func tesFetchImageByURLSuccess() async throws {
        let mockImageUseCase = MockImageUseCase()
        let viewModel = ImageViewModel(loadImageDataUseCase: mockImageUseCase)
        
        await viewModel.fetchImage(localUrl: URL(string: "image/document/image.png")!)
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        #expect(viewModel.image != nil)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func tesFetchImageByURLFailure() async throws {
        let mockImageUseCase = MockImageUseCase()
        mockImageUseCase.errorToThrow = CustomError.message("mock error")
        let viewModel = ImageViewModel(loadImageDataUseCase: mockImageUseCase)
        
        await viewModel.fetchImage(localUrl: URL(string: "image/document/image.png")!)
        try await Task.sleep(nanoseconds: 100_000_000)
        
        #expect(viewModel.image == nil)
    }
}
