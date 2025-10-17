//
//  ImportMediaBottomSheetViewModelTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
import Combine
import Testing
@testable import SocialMediaApp

struct ImportMediaBottomSheetViewModelTests {
    
    @Test(.tags(.viewmodel, .unit))
    func testInitialization() async throws {
        let viewModel = ImportMediaBottomSheetViewModel()
        
        #expect(viewModel.loadState == .unknown)
        #expect(viewModel.showErrorAlert == false)
        #expect(viewModel.errorMessage == "")
        #expect(viewModel.isImporting == false)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.resolvedMediaURL == nil)
        #expect(viewModel.mediaAttachment == nil)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testPublishedPropertiesAreObservable() async throws {
        let viewModel = ImportMediaBottomSheetViewModel()
        var cancellables = Set<AnyCancellable>()
        var loadStateChanges: [LoadState] = []
        var isImportingChanges: [Bool] = []
        
        // IMPORTANT: Combine publishers emit their current value immediately upon subscription
        viewModel.$loadState
            .sink { state in
                loadStateChanges.append(state)
            }
            .store(in: &cancellables)
        viewModel.$isImporting
            .sink { flag in
                isImportingChanges.append(flag)
            }
            .store(in: &cancellables)
        
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        #expect(loadStateChanges.count > 0)
        #expect(isImportingChanges.count > 0)
        #expect(loadStateChanges.first == .unknown)
        #expect(isImportingChanges.first == false)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testLoadStateChangeToLoading() async throws {
        // Given
        let viewModel = ImportMediaBottomSheetViewModel()
        
        // When
        viewModel.loadState = .loading
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        // Then
        #expect(viewModel.loadState == .loading)
        #expect(viewModel.isLoading == true)
        #expect(viewModel.showErrorAlert == false)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testLoadStateChangeToFailed() async throws {
        // Given
        let viewModel = ImportMediaBottomSheetViewModel()
        
        // When
        viewModel.loadState = .failed
        try await Task.sleep(nanoseconds: 500_000_000)
        
        // Then
        #expect(viewModel.loadState == .failed)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.showErrorAlert == true)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testLoadStateChangeToUnknown() async throws {
        // Given
        let viewModel = ImportMediaBottomSheetViewModel()
        
        // When
        viewModel.loadState = .unknown
        try await Task.sleep(nanoseconds: 100_000_000)
        
        // Then
        #expect(viewModel.loadState == .unknown)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.showErrorAlert == false)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testLoadStateChangeToLoaded() async throws {
        // Given
        let viewModel = ImportMediaBottomSheetViewModel()
        let url = FileServiceTestHelper.createTestImageFile(fileName: "test", folderName: "test.png", directory: .documents)
        // When
        
        viewModel.loadState = .loaded(url)
        try await Task.sleep(nanoseconds: 100_000_000)
        
        // Then
        #expect(viewModel.loadState == .loaded(url))
        #expect(viewModel.isLoading == false)
        #expect(viewModel.showErrorAlert == false)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testUpdateDataSuccess() async throws {
        // Given
        let viewModel = ImportMediaBottomSheetViewModel()
        let url = FileServiceTestHelper.createTestImageFile(fileName: "test", folderName: "test.png", directory: .documents)
        let result: Result<[URL], Error> = .success([url!])
        
        // When
        viewModel.updateData(result)
        
        // Then
        #expect(viewModel.loadState == .loaded(url!))
        #expect(viewModel.resolvedMediaURL == url!)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testUpdateDataFailure() async throws {
        // Given
        let viewModel = ImportMediaBottomSheetViewModel()
        let result: Result<[URL], Error> = .failure(CustomError.message("mock error"))
        
        // When
        viewModel.updateData(result)
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        // Then
        #expect(viewModel.loadState == .failed)
        #expect(viewModel.showErrorAlert == true)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testMediaTypeSuccess() async throws {
        // Given
        let viewModel = ImportMediaBottomSheetViewModel()
        let url = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
        
        // When
        let type = viewModel.mediaType(url: url!)
        
        // Then
        #expect(type != nil)
        #expect(type == MediaType.image)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testMediaTypeFailure() async throws {
        // Given
        let viewModel = ImportMediaBottomSheetViewModel()
        let url = URL(string: "media/documents/image.unkown")
        
        // When
        let type = viewModel.mediaType(url: url!)
        
        // Then
        #expect(type == nil)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testHandleGalleryPickingError() async throws {
        // Given
        let viewModel = ImportMediaBottomSheetViewModel()
        let errorMessage = AppText.failPickingFromGallery
        let loadState: LoadState = .failed
        
        // When
        await viewModel.handleGalleryPickingError()
        
        // Then
        #expect(viewModel.errorMessage == errorMessage)
        #expect(viewModel.loadState == loadState)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testHandleError() async throws {
        // Given
        let viewModel = ImportMediaBottomSheetViewModel()
        let errorMessage = AppText.mediaTypeUnknown
        
        // When
        await viewModel.handleError()
        
        // Then
        #expect(viewModel.errorMessage == errorMessage)
        #expect(viewModel.showErrorAlert == true)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testHideError() async throws {
        // Given
        let viewModel = ImportMediaBottomSheetViewModel()
        
        // When
        viewModel.hideError()
        
        // Then
        #expect(viewModel.errorMessage == "")
        #expect(viewModel.showErrorAlert == false)
    }
}
